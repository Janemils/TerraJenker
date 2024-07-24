# Documentation for Using the TerraJenker Repo.
Steps to use this repo.

1. Bring up a VM [Can be EC2 or any other VMs]. (Will automate this step soon in Terraform)
2. Clone this repo in the VM.
3. Run the Jenkins-Docker.sh file. This shell script will install Jenkins and Docker in your VM.
4. Once the script has executed successfully, copy the administrator password. 
5. You can open Jenkins with the VM public IP and port 8080. Use the copied password and install the required plugins and sign in.
6. Once you have signed in, you can create a new pipeline with the JENKINSFILE that's available in the repo.
7. Ensure that you have saved you dockerhub credentials in Jenkins. You must also modify the JENKINSFILE to use your image tag.
8. Once the above step is completed, Run your build.
9. If everything is successful, you should open a new tab with the VM public IP and port 3000. You should be able to view something similar to the image below.

    ![image](https://github.com/user-attachments/assets/67ce4f1c-b17b-4d75-8477-121c63eb9ccb)
    ![image](https://github.com/user-attachments/assets/ac33621f-7e9d-489d-9feb-c915ed1d9f5a)

Reference:
- Devops Project | CI/CD Setup : https://www.youtube.com/watch?v=q3S_B5cX_6o&list=PLr5IlaMG846FinrEdWZmGQjt3s20zg6PI&index=1
- ToDo List App Github Repo used: https://github.com/dockersamples/todo-list-app.git
