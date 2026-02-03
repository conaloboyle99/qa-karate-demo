pipeline {
    agent any

    stages {

        stage('Pipeline Check') {
            steps {
                echo "✅ Jenkins pipeline is running!"  // Quick verification stage
            }
        }

        stage('Checkout') {
            steps {
                git url: 'https://github.com/conaloboyle99/qa-karate-demo.git',
                    branch: 'main',
                    credentialsId: 'github-karate'
            }
        }

        stage('Run Karate Tests') {
            steps {
                echo "Running Karate tests using Maven wrapper..."
                sh './mvnw clean test'
            }
        }

        stage('Archive Test Results') {
            steps {
                archiveArtifacts artifacts: 'target/surefire-reports/**/*.xml', allowEmptyArchive: true
                junit 'target/surefire-reports/**/*.xml'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Check results above."
        }
        success {
            echo "🎉 Build and tests successful!"
        }
        failure {
            echo "❌ Build or tests failed. Check console output for details."
        }
    }
}