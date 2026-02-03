pipeline {
    agent any

    // Use tools installed in Jenkins
    tools {
        maven 'Maven'     // Name from Global Tool Config
        jdk 'jdk17'   // Your configured JDK
    }

    environment {
        KARATE_DIR = 'karate'   // Relative path to Karate project
    }

    stages {

        stage('Pipeline Check') {
            steps {
                echo "✅ Jenkins pipeline is running!"
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Run Karate Tests') {
            steps {
                dir("${KARATE_DIR}") {
                    echo "🏃 Running Karate tests using Maven..."
                    // Run Maven clean test
                    sh 'mvn clean test'
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                dir("${KARATE_DIR}") {
                    // Archive surefire JUnit reports for visibility in Jenkins
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            echo "❌ Build or tests failed. Check console output for details."
        }
        always {
            echo "📝 Pipeline finished. Review the stages and test results above."
        }
    }
}