pipeline {
    agent any
    environment {
        imagename = "sgoser/python-webserver"
        registry = "registry.hub.docker.com"
        registryCredential = 'dockerhub'
    }        
    options {
        buildDiscarder(logRotator(numToKeepStr:'5'))
    }
    stages {
        stage('Checkout. Clone repository') {
            steps {
                git url: 'https://github.com/sgoser/python.webserver', branch: 'main'
            }
        }
        stage ("Lint Dockerfile") {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'
                }
            }
            steps {
                sh 'hadolint Dockerfile | tee -a hadolint_lint.txt'
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'
                }
            }
        }
        stage("Build image") {
            steps {
                script {
                    my_app = docker.build("$imagename:jv${env.BUILD_ID}", "--network=host -f Dockerfile .")
                }
            }
        }
        stage('Test image') {
            steps {
                sh "docker run -d --rm -p 8000:8000 --name test_image $imagename:jv${env.BUILD_ID}"
                sh "sleep 5"
                sh 'wget http://localhost:8000 -O index.html.log'
                archiveArtifacts artifacts: 'index.html.log'
                sh "docker stop test_image"
            }
        }
        stage('Push Image to repo') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    my_app.push("jv${env.BUILD_ID}")
                    }
                }
            }
        }
        stage('Cleaning. Delete builded image') {
            steps {
                script {
                sh "docker rmi $imagename:jv${env.BUILD_ID}"
                }
            }
        }
    }
}