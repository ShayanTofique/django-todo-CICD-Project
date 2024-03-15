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

![local host](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/9f74349e-612e-4ce5-afdc-1a42af668380)

## Deployment Steps
1. **Deploying on AWS EC2**:
    - Launch an AWS EC2 instance and configure security groups to allow inbound traffic on port 8000.
    - SSH into the EC2 instance and clone the repository.
    - Install Docker and Docker Compose on the EC2 instance.
    - Build and run the Docker container for the ToDo application.

   **Building the Docker Image**

To build the Docker image, execute the following command within your terminal:

```bash
docker build . -t todo-app
```

This command builds a Docker image named `todo-app` using the instructions defined in the Dockerfile.

   **Running the Docker Container**

After successfully building the Docker image, you can run the ToDo application as a Docker container using the following command:

```bash
sudo docker run -p 8000:8000 -d todo-app
```

This command starts a Docker container named `todo-app`, detached (`-d`) from the terminal, and maps port 8000 of the container to port 8000 on the host machine, allowing access to the ToDo application.

![Screenshot from 2024-02-18 15-23-54](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/ee354045-a39a-4ed9-b1b0-c9c6f209d648)


2. **Setting Up Jenkins Pipeline**:

To establish a Continuous Integration/Continuous Deployment (CI/CD) pipeline for the ToDo application, Jenkins is utilized. Follow the steps below to install Jenkins and configure the pipeline:

### Installing Jenkins

1. Ensure you're logged into your EC2 instance environment:
    ```bash
    ubuntu@ip-172-31-18-89:~$
    ```

2. Install Jenkins on the EC2 instance.

3. After installation, check the status of Jenkins:
    ```bash
    sudo systemctl status jenkins
    ```

4. Jenkins runs on port 8080. Ensure this port is unblocked on your EC2 instance by updating the security group settings:
    - Navigate to **Security Groups** in your AWS console.
    - Edit the inbound rules to allow traffic on port 8080.
    - Add a custom TCP rule for port 8080, with the source set to `0.0.0.0/0`.

### Installing Jenkins Using Docker

Alternatively, Jenkins can be installed using Docker. Follow these steps:

1. Pull the Jenkins LTS image:
    ```bash
    sudo docker pull jenkins/jenkins:lts
    ```

2. Run Jenkins as a Docker container:
    ```bash
    sudo docker run -d -p 8080:8080 <container_id>
    ```

3. Access Jenkins at `http://<your_ec2_ip>:8080/`.

## Setting Up CICD Pipeline with Jenkins and GitHub Integration

To establish a Continuous Integration and Continuous Delivery(CICD) pipeline for the ToDo application, we'll connect GitHub and Jenkins, allowing automatic code deployment upon each commit. Follow the steps below to integrate GitHub with Jenkins and set up the CI pipeline:

### GitHub Setup

1. **Generate Personal Access Token**:
   - Go to your GitHub profile settings.
   - Navigate to **Developer settings** and select **Personal access tokens**.
   - Create a new token with access to the necessary permissions (typically, repo access).
   - Copy the generated token.

2. **Create Repository**:
   - Create a repository in your GitHub profile to host your project code.
   - Copy the repository link for pushing code.

3. **Push Code to Repository**:
   - In your terminal, add your repository link as the origin branch.
   - After committing the code, push it to GitHub. When prompted for credentials, use your GitHub personal access token as the password.

### Jenkins Configuration

1. **Install Git Plugin**:
   - Install the Git client plugin in Jenkins to enable integration with GitHub.

2. **Configure GitHub Server**:
   - Go to **System Configuration** in Jenkins.
   - Add a GitHub server by providing your personal access token in the credentials section.
   - Choose the secret text option and add your personal access token.
   - Test the connection to ensure successful integration.

3. **Create Jenkins Job**:
   - Create a new Jenkins job.
   - In the source code management section, select Git and provide your project repository link.
   - Specify the branch name to monitor for changes.

4. **Define Build Steps**:
   - Add build steps to the job configuration to execute commands necessary for building and running the ToDo application.
   - For example:
     ```bash
     docker build . -t todo-app
     docker run -d -p 8000:8000 todo-app python manage.py runserver 0.0.0.0:8000
     ```

5. **Save and Trigger Build**:
   - Save the job configuration.
   - Trigger the build manually or set up automatic triggering upon code commits.

By setting up this CICD pipeline, code changes pushed to the GitHub repository trigger Jenkins to automatically build and deploy the ToDo application, ensuring continuous integration and delivery of the project.

## Implementing Docker Compose for the ToDo Application

To streamline the deployment process of the ToDo application, Docker Compose is utilized. Follow the steps below to set up Docker Compose for your project:

### Running Docker Compose

1. **Install Docker Compose**:
   - If not already installed, install Docker Compose on your system.

2. **Running Containers**:
   - Execute the following command to start the containers defined in the `docker-compose.yml` file:
     ```bash
     sudo docker-compose up
     ```
   - This command will build the Docker image and start the container. The ToDo application will be accessible at port 8000.

3. **Background Running**:
   - For background running, use the `-d` flag:
     ```bash
     docker-compose up -d
     ```

### CICD Implementation

To implement CI/CD for your project using Docker Compose, follow these steps:

1. **Stopping Existing Containers**:
   - Execute `docker-compose down` to stop any existing containers.

2. **Forcing Recreation**:
   - Use the following command to ensure containers are recreated:
     ```bash
     docker-compose up -d --force-recreate --no-deps --build web
     ```
   - This command forces recreation of containers, rebuilds the Docker image, and starts the services.

 ![Screenshot from 2024-02-19 13-00-26](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/28f3a877-c428-4673-801b-dfbf51b4fc3a)

By incorporating Docker Compose into the project, you can easily manage the deployment of the ToDo application and automate the CI/CD pipeline for efficient development and deployment workflows.

[CICD.webm](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/a420104f-1404-4951-9217-ea6d63de55da)

### Setting Up Kubernetes for ToDo Application

To leverage Kubernetes for managing the deployment and scaling of the ToDo application, follow the steps outlined below:

#### 1. Push Container Image to Docker Hub

1. Log in to Docker Hub using `docker login` and provide your credentials.
2. Tag your Docker image with the repository name:
   ```bash
   docker tag <image> <repo>
   ```
3. Push the tagged image to Docker Hub:
   ```bash
   docker push <image>
   ```

![Screenshot from 2024-03-12 15-54-34](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/41261e22-b73b-46cf-9fb6-221e8da0e0ba)

#### 4. Install Kubernetes Tools

Install `kubectl` and `minikube` on your AWS EC2 instance. Note: Ensure your instance type is at least `t2.medium` as Kubernetes clusters require a minimum of two CPUs.

#### 5. Deploy Pod to Kubernetes Cluster

Execute the following commands to deploy the pod configuration to your Kubernetes cluster:

```bash
kubectl apply -f pod.yaml
kubectl get pods
kubectl get pods -o wide
```

#### 6. Access the Application

1. Log in to the Kubernetes cluster:
   ```bash
   minikube ssh
   ```
2. Use `curl` to access the ToDo application:
   ```bash
   curl http://<ip-address>:8000
   ```

![Screenshot from 2024-03-12 16-15-46](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/d860908b-4bb9-4159-9aaa-bb598651e90b)

### Note:

While pods serve as the basic building blocks of Kubernetes, they are not typically deployed directly in production. Kubernetes employs higher-level abstractions like deployments and stateful sets for production-grade deployments.

### Kubernetes Deployment for ToDo Application

Kubernetes deployment offers several advantages such as AutoHealing and AutoScaling, ensuring seamless operation and scalability of your application. Follow the steps below to deploy the ToDo application using Kubernetes deployment:

#### 1. Apply Deployment Configuration

Apply the deployment configuration to your Kubernetes cluster using `kubectl`:
```bash
kubectl apply -f deploy.yaml
```

#### 2. Verify Pod Status

Check the status of the pod to ensure it's running successfully:
```bash
kubectl get pods
```



#### AutoHealing and AutoScaling

- **AutoHealing**: Kubernetes deployment ensures auto-healing by continuously monitoring the state of the pods. If a pod crashes or is deleted, Kubernetes automatically restarts it to maintain the desired state defined in the deployment configuration.

- **AutoScaling**: Kubernetes deployment enables auto-scaling by allowing you to adjust the number of replicasets based on workload demands. For example, during peak traffic events like holidays or promotions, you can increase the number of replicas to handle the increased load:

By utilizing Kubernetes deployment, you ensure high availability, fault tolerance, and scalability for your ToDo application, enabling it to handle varying workloads efficiently.

### Exposing ToDo Application with Kubernetes Service

When deploying applications within Kubernetes, it's essential to expose them to external access for seamless communication between services and to enable access from outside the cluster. Kubernetes Services play a crucial role in achieving this. Follow the steps below to expose your ToDo application using Kubernetes Service:

#### 1. Understanding the Need for Kubernetes Service

Kubernetes Services provide a networking component for your Kubernetes cluster, enabling service discovery and facilitating communication between various applications running within the cluster. Unlike deployments, which provide static IP addresses for pods, Services offer a robust service discovery mechanism, ensuring consistent accessibility even if pod IP addresses change.

#### 2. Define Service Configuration

Create a file named `service.yaml` and define the Service configuration for your ToDo application:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: todo-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8000
```

#### 3. Create Service

Apply the Service configuration to create the Kubernetes Service:
```bash
kubectl apply -f service.yaml
```

#### 4. Verify Service

Check the status of the Service to ensure it's created successfully:
```bash
kubectl get svc
```

#### 5. Access the Application

Access the ToDo application using the IP address of the Service. You can either use the Minikube IP address or NodePort to access the application from outside the cluster.

- Using NodePort (for accessing outside the cluster):
  ```bash
  curl -L http://<minikube_ip>:<node_port>
  ```

![Screenshot from 2024-03-15 00-30-28](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/8a8e9dda-0a22-418e-bf15-48560f9a71e0)

![Screenshot from 2024-03-15 00-32-17](https://github.com/ShayanTofique/django-todo-CICD-Project/assets/93067602/9777cca3-8923-4126-91e6-f6432b4913cc)

#### Advantages of Kubernetes Service

1. **Service Discovery**:
   Kubernetes Service provides robust service discovery, allowing different services within the cluster to communicate seamlessly by abstracting away the dynamic nature of pod IP addresses.

2. **Accessing App Outside the Cluster**:
   Kubernetes Service enables access to applications from outside the cluster. You can use NodePort or LoadBalancer type services to expose your application and make it accessible from external sources.

By leveraging Kubernetes Services, you ensure reliable communication between services within your cluster and enable external access to your applications, thereby enhancing the overall functionality and accessibility of your Kubernetes-based deployments.
