#main stage
#using maven an jdk to compile the java app
#choosing multi stage build keeps the final image size small and secure
FROM maven:3.9.6-eclipse-temurin-17 AS foundation
#installing build time dependencies curl and unzip
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*


# sets working directory
WORKDIR /app 
#copying pom first for layer caching which allows to cache dependencies if pom is unchanged
COPY pom.xml .
RUN mvn dependency:go-offline
# copying application code
COPY src ./src
#building the app and skipped the tests to make ci fast
RUN mvn clean package -DskipTests

# download and integrated new relic agent
RUN curl -L https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip \
  -o newrelic.zip && \
  unzip newrelic.zip && \
  rm newrelic.zip

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
#copying new relic agent to runtime image
COPY --from=foundation /app/newrelic /app/newrelic
#copying alreadu built jar file from foundation stage
#keeps run time image small
COPY --from=foundation /app/target/*.jar mal_ai.jar
#expose app port
EXPOSE 8080
#environment variables for new relic
ENV NEW_RELIC_APP_NAME="java-fargate-app"
ENV NEW_RELIC_LOG=stdout
#health check to see app is running properly
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s \
  CMD wget -qO- http://localhost:8080/health || exit 1
#strating the app
ENTRYPOINT ["java","-javaagent:/app/newrelic/newrelic.jar","-jar","mal_ai.jar"]
