# Final-Task-CI-CD-ITI-IAC
This repository contains Terraform configuration for setting up infrastructure on Google Cloud Platform (GCP) using Infrastructure as Code (IaC) principles, Installing Jenkins (using Ansible https://github/hossamshawky/) and build pipeline to deploy an application on GKE 

</br>

---

</br>

## Requirements

-   git & 
-   Terraform
-   Docker
-   Google Cloud SDK
-   Access to a GCP project with the necessary permissions to create and manage resources.
-   A bucket for the terraform state.

</br>

---

</br>

## Diagram
![alt](./screenshots/)

</br>

---

</br>

## How To Use

1. clone this repo :
   ```bash
    git clone https://github.com/hossamShawky/Final-Task-CI-CD-ITI-IAC/
   ```

2. Change Directory To : terraform-files
   ```bash
   cd terraform-files
   ```

3. Customize Values in "values.auto.tvars" as your project details

4. Run terraform commands:
    ```bash
    terraform init
    ```
    
    ```bash
    terraform apply
    ```

</br>

---

</br>

### Private VM "setup cluster deployments"

1. SSH From Browser

2. Update Packages & Install Kubectl
  ```bash
     sudo apt update -y
  ```
  ```bash
    sudo apt-get install kubectl
  ```

3. Google Auth Login
  ```bash
    gcloud auth login
  ```        
  "Follow Steps To Auth Login"

4. Install gcloud and 
  ```bash
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  ```

5. Connect to cluster (Replace Zone and prject with your customization)
  ```bash
       gcloud container clusters get-credentials iti-cluster --zone us-east1-b --project  iti-gcp-hossam
  ```

6. Apply deployments files "Cpoyied to private-vm From Local PC in meta-data"
  ```bash
       kubectl apply -f deployments
  ```
    This command will create jenkins&app namespaces,jenkins-deployment,jenkins-service,jenkins-service-account,jenkins-volume,slave-deployment and slave-service.

<br>

---

<br>

### Jenkins Configrations
1. open jenkins loadbalancer Endpoint
   ```bash
      kubectl get services -n jenkins
   ```

2. Exec your running container and get first password
    ```bash
       kubectl exec -it <running-container-name> -n jenkins -- bash
    ```
    "cat path-appears-when-open-jenkins"

3. open Jenkins & create users and passwords.

4. Configure github,dockerHub,kubeconfig and slave (node: "jenkins,123456") credentials.     

5. Create Multibransh Pipline from Git repo: https://github.com/hossamShawky/Final-Task-CI-CD-ITI-Simple-App/.

6. Create new node with name "iti-node" and credentials usernameandpassword.

7. Choose a branch and click build now.

<br>

---

<br>

### Steps & Outputs Screenshots
