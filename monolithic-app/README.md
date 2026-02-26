# Monolithic Application – DevOps Deployment Training

## Overview
This Spring Boot application was used during DevOps training to understand how a monolithic application is packaged and deployed.

The focus of this project was infrastructure and deployment, not application development.

## Objectives Covered

- Building a Spring Boot application using Maven
- Generating executable JAR files
- Running application on Linux/EC2 instance
- Configuring Security Groups

## Architecture Type

Monolithic Architecture:
- Single codebase
- Single deployable unit
- Single runtime instance

## Build Instructions

mvn clean package -DskipTests

## Run Locally

java -jar target/monolithic-app-0.0.1-SNAPSHOT.jar