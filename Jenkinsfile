pipeline {
    agent any

    // Use tools installed in Jenkins
    tools {
        jdk 'jdk17'   // matches your configured JDK
    }

    environment {
        KARATE_DIR = 'karate'   // Relative path to Karate project
        REPORTS_DIR = 'reports' // Top-level custom reports folder
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
                    echo "🏃 Running Karate tests using Maven wrapper..."
                    // Ensure Maven wrapper is executable and run tests
                    sh 'chmod +x mvnw'
                    sh './mvnw clean test'
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                // Archive Maven Surefire JUnit reports
                dir("${KARATE_DIR}") {
                    junit '**/target/surefire-reports/*.xml'
                }
                // Archive any top-level custom reports
                dir("${REPORTS_DIR}") {
                    junit '**/*.xml'
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