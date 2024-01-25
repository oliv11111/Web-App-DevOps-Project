# Milestone 2: DevOps Project - README

## Introduction

The Project has undergone Docker containerization, providing a streamlined and reproducible deployment process. 

### How It Works - Docker Containerization Process

#### Step 1: Dockerfile Creation

Create a Dockerfile in the project root directory specifying the application's dependencies and configuration.

```Dockerfile
# TODO: Step 1 - Use an official Python runtime as a parent image
FROM python:3.8-slim

# TODO: Step 2 - Set the working directory in the container
WORKDIR /app

# TODO: Step 3 - Copy the application files into the container
COPY . /app

# TODO: Step 4 - Install Python packages specified in requirements.txt
RUN pip install --upgrade pip setuptools
RUN pip install -r requirements.txt

# TODO: Step 5 - Expose port
EXPOSE 5000

# TODO: Step 6 - Define Startup Command
CMD ["python", "app.py"]
```
#### Step 2: Building the Docker Image
```Bash
docker build -t devops-project:v1.0 .
```
#### Step 3: Tagging the Image
```Bash
docker tag devops-project:v1.0 oliv11111/devops-project:v1.0
```
#### Step 4: Pushing to Docker Hub
```Bash
docker push oliv11111/devops-project:v1.0
```
#### Step 5: Testing Push (Pulling from DockerHub)
```Bash
docker pull oliv11111/devops-project:v1.0
```
#### Step 6: Running Locally
```Bash
docker run -p 5000:5000 devops-project:v1.0
```
####  Step 7: Clean Up
```Bash
# Remove containers
docker ps -a
docker rm <container-id>
# Remove images
docker images -a
docker rmi <image-id>
```

### Benefits

Docker's fast deployment enables developers to test and iterate quickly, accelerating the development lifecycle.

#### Branch Information:

- The feature was implemented in a branch named `initialise-docker`.

## For End-Users

### Benefits

Docker containerization significantly benefits the DevOps Project by providing portability, isolation, and reproducibility. Containers encapsulate the application and its dependencies, ensuring consistent performance across different environments. The lightweight nature of containers enhances resource efficiency and scalability, allowing for seamless deployment and easy horizontal scaling. Docker's versioning capability and centralized repository, Docker Hub, streamline collaboration and version control.

