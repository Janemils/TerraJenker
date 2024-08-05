pipeline {
    agent any

    stages {
        stage('Git Repo Branch.') {
            steps {
                git branch: 'main', url: 'https://github.com/dockersamples/todo-list-app.git'
                sh 'ls'
            }
        }
        stage('Docker Image Build') {
            steps {
                                // must use your docker credentials and tag.
                sh 'docker image build  --no-cache -t janemils/jenkins-dock:v$BUILD_ID .'
                sh 'docker image tag janemils/jenkins-dock:v$BUILD_ID janemils/jenkins-dock:v$BUILD_ID'
                
            }
        }
        stage('Docker Image Push') {
            steps {
                // must use your docker credentials and tag.
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                        sh "docker login -u ${user} -p ${pass}"
                        sh 'docker push janemils/jenkins-dock:v$BUILD_ID'
                        sh 'docker rmi janemils/jenkins-dock:v$BUILD_ID'
                    }
            }
        }
        stage('Docker Container Creating') {
            steps {
                sh 'docker run -itd --name todoapp$BUILD_ID -p 3000:3000 janemils/jenkins-dock:v$BUILD_ID'
            }
        }
    }
}
