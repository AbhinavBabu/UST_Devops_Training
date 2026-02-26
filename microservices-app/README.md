# Microservices Architecture – DevOps Deployment Training

## Overview

This project demonstrates a microservices-based architecture used during DevOps training to understand distributed deployment and load balancing.

The primary objective was to learn infrastructure configuration and service orchestration rather than business logic implementation.

## Services Included

- user-service
- order-service
- homepage (static frontend demo)

## Objectives Covered

- Running multiple services on different ports
- Independent service deployment
- EC2 instance hosting
- Application Load Balancer configuration
- Target Groups setup
- Health checks
- Traffic routing

## Architecture Type

Microservices Architecture:
- Independent deployable services
- Separate runtime environments

## Build Each Service

mvn clean package -DskipTests

## Run Locally

java -jar target/service-name.jar --server.port=8081