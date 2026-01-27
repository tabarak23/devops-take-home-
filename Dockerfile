#main stage
#using maven an jdk to compile the java app
#choosing multi stage build keeps the final image size small and secure
FROM maven:3.9.6-eclipse-temurin-17 AS foundation
# sets working directory
WORKDIR /app 
#copying pom first for layer caching which allows to cache dependencies if pom is unchanged
COPY pom.xml .
RUN mvn dependency:go-offline
# copying application code
COPY src ./src
#building the app and skipped the tests to make ci fast
RUN mvn clean package -DskipTests

# last stage
#lightweight jre image to run the app
#could have used distrolesss but health check would break coz it doesnt support shell annd pacakage managers
#alpine reduces image size and still supports shell commands
FROM eclipse-temurin:17-jre-alpine 
#creating non root user for security 
RUN addgroup -S tabarak && adduser -S tabarak -G tabarak
#switching to non root user
USER tabarak
WORKDIR /app
#copying alreadu built jar file from foundation stage
#keeps run time image small
COPY --from=foundation /app/target/*.jar app.jar
#expose app port
EXPOSE 8080
#health check to see app is running properly
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s \
  CMD wget -qO- http://localhost:8080/health || exit 1
#strating the app
ENTRYPOINT ["java","-jar","app.jar"]
