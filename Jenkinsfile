pipeline {
    agent any

    tools {
        maven 'Maven'  // The Maven name you configured
        jdk 'JAVA_HOME' // Your JDK configured in Jenkins
    }

    stages {
        stage('Pipeline Check') {
            steps {
                echo "✅ Jenkins pipeline is running!"
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Karate Tests') {
            steps {
                dir('karate') { // Change to the karate/ folder
                    echo "Running Karate tests using Maven..."
                    sh "mvn clean test"
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Check test results above."
        }
    }
}