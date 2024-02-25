# Automated Deployment of ToDo Application with Full CI/CD Pipeline

## Overview
This project showcases the automated deployment of a ToDo application using Docker containers and a full CI/CD pipeline with Jenkins. The application is orchestrated with Kubernetes for scalability and efficient resource management.

## Technologies Used
- AWS EC2
- Docker
- Jenkins
- Docker Compose
- Kubernetes

## Project Setup
1. **Local Environment Setup**: Before deploying the application, ensure you have the following prerequisites installed on your local system:
    - Docker: [Installation Instructions](https://docs.docker.com/get-docker/)
    - Docker Compose: [Installation Instructions](https://docs.docker.com/compose/install/)
    - Python (if applicable): [Installation Instructions](https://www.python.org/downloads/)

2. **Clone Repository**: Clone the repository to your local machine.
    ```bash
    git clone <repository_url>
    cd todo-application
    ```

3. **Install Requirements**: Install the required dependencies for the ToDo application.
    ```bash
    pip install -r requirements.txt
    ```

4. **Run Application Locally**: Run the ToDo application locally for testing.
    ```bash
    python manage.py runserver
    ```

5. **Access ToDo Application**: Access the ToDo application by navigating to `http://localhost:8000` in your web browser.

## Deployment Steps
1. **Deploying on AWS EC2**:
    - Launch an AWS EC2 instance and configure security groups to allow inbound traffic on port 5000.
    - SSH into the EC2 instance and clone the repository.
    - Install Docker and Docker Compose on the EC2 instance.
    - Build and run the Docker container for the ToDo application.

2. **Setting Up Jenkins Pipeline**:
    - Install Jenkins on a separate server or local machine.
    - Configure Jenkins to connect to the repository and trigger builds upon code commits.
    - Create Jenkins jobs to build, test, and deploy the ToDo application using Docker Compose.

3. **Implementing Kubernetes Orchestration**:
    - Set up a Kubernetes cluster using a platform like AWS EKS or Minikube.
    - Define Kubernetes manifests for deploying the ToDo application, including deployments, services, and ingress resources.

## Contributing
Contributions are welcome! Please feel free to submit pull requests or raise issues if you encounter any problems or have suggestions for improvements.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This README file provides a detailed guide for setting up the project environment, deploying the application locally, and outlining the steps followed throughout the project, including deployment on AWS EC2, setting up Jenkins pipeline, and implementing Kubernetes orchestration.