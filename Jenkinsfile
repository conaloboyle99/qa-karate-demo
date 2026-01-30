pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Cypress UI Tests') {
            agent {
                docker {
                    image 'cypress/included:13.6.2'
                }
            }
            steps {
                sh 'npm install'
                sh 'npx cypress run'
            }
        }

        stage('Karate API Tests') {
            agent {
                docker {
                    image 'maven:3.9.6-eclipse-temurin-17'
                }
            }
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/*.xml', allowEmptyArchive: true
        }
    }
}