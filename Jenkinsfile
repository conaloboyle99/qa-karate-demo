pipeline {
    agent any

    environment {
        WORKDIR = 'karate'       // Folder containing pom.xml
        MAVEN_CMD = './mvnw'     // Maven wrapper
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
                // Change directory to where pom.xml exists
                dir("${WORKDIR}") {
                    echo "Running Karate tests using Maven wrapper..."
                    sh "${MAVEN_CMD} clean test"
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                dir("${WORKDIR}") {
                    archiveArtifacts artifacts: 'target/surefire-reports/**/*.xml', allowEmptyArchive: true
                    junit 'target/surefire-reports/**/*.xml'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Check test results above."
        }
        success {
            echo "✅ Build and tests completed successfully!"
        }
        failure {
            echo "❌ Build or tests failed. Check console output for details."
        }
    }
}