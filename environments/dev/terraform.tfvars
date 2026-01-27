project_name = "mal-exercise"
stage        = "dev"
aws_region   = "us-west-1"
vpc_cidr     = "10.0.0.0/16"



#ecs service repeatedly failed with the error failed to normalize image reference "PLACEHOLDER_IMAGE"

#The ECS task definition was created with a placeholder image value before a valid Docker image was available in Amazon ECR.

#Passed the container image URI as a Terraform variable

#Used an environment-specific image reference:

image = "392066615426.dkr.ecr.us-west-1.amazonaws.com/mal-exercise-dev:latest"
