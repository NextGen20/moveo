
DevOps Home Assignment:

create a Terraform configuration named main.tf to build a foundational infrastructure on AWS for Kubernetes deployment using Minikube.
This setup involves crafting a single VPC for all environments, encompassing two subnets - one public and one private.
A NAT Gateway is crucial in this architecture for enabling internet connectivity, which facilitates the EC2 instance within the private subnet to access online resources, necessary for downloading and installing Minikube.

Once the main.tf file is set up and applied, the next step involves accessing the EC2 machine. Since the instance is located in the private subnet, direct access via a public IP is not feasible.
Therefore, an EC2 single endpoint is created within the VPC, allowing secure and straightforward connectivity to the instance.
Upon establishing a connection with the EC2 instance, the initial step is to install the Kubernetes engine.
For this purpose, Docker is chosen and installed using the command sudo snap install docker.
Following the setup of the containerization platform, it’s essential to install kubectl, the command-line tool for interacting with Kubernetes clusters.
The installation steps for kubectl include downloading the latest version, making the binary executable, and moving it to the system's PATH for easy access.
Post the installation of kubectl, the focus shifts to setting up Minikube, a tool to run Kubernetes locally on the EC2 instance.
This involves downloading the latest Minikube binary, making it executable, and moving it to the system's PATH.
Starting Minikube initializes a local Kubernetes cluster on the instance.
The final phase of the assignment is centered around the deployment and external exposure of an Nginx server on the Kubernetes cluster.
This requires writing a YAML configuration file that specifies the deployment details, including the use of a custom Docker image hosted on Docker Hub.
To make the Nginx server accessible externally, an additional service configuration, such as NodePort or LoadBalancer, is defined in another YAML file.

Aws diagram:

![diagram](https://github.com/NextGen20/moveo/assets/71230554/ca874082-3ee2-4763-9a73-50657f1c8dc9)



minikube start & config :

![minikube-start](https://github.com/NextGen20/moveo/assets/71230554/6a7630cd-cd5f-4ff2-b545-d4ae502f8144)
![minikube-status](https://github.com/NextGen20/moveo/assets/71230554/75583316-de2b-4141-b85e-d42c4bca2e57)

Kubernetes Deployment:

![Kubernetes Deployment](https://github.com/NextGen20/moveo/assets/71230554/ba81bedc-30c1-40c0-ab04-3fbc629f424d)
