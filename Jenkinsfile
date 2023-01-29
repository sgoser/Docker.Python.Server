pipeline {
    agent any
    triggers {
        cron('H */1 * * *')
    }
    options {
        buildDiscarder(logRotator(numToKeepStr:'5'))
    }
    stages {
        stage('Clone repository') {
            steps {
                git url: 'https://github.com/sgoser/python.webserver', branch: 'main'
            }
        }
        stage('Checking repository'){
            steps {
                sh "ls -l"
            }
        }
        stage('Packing project') {
            steps {
                sh """
                tar -zcvf /tmp/package.tar.gz  ./
                date
                """
                deleteDir()
                sh "mv /tmp/package.tar.gz  ./"
            }
        }
        stage('Packing test') {
            steps {
                sh "ls -l"
            }
        }
    }
}