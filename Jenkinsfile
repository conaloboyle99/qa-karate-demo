pipeline {
    agent any

    tools {
        jdk 'jdk17'   // Your configured JDK
    }

    environment {
        KARATE_DIR = 'karate'
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

        stage('Run Karate Tests in Parallel') {
            parallel {
                stage('API Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            echo "🏃 Running API tests..."
                            sh './mvnw clean test -Dkarate.options="--tags @api"'
                        }
                    }
                }
                stage('UI Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            echo "🏃 Running UI tests..."
                            sh './mvnw clean test -Dkarate.options="--tags @ui"'
                        }
                    }
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true
            }
        }
    }

    post {
        success { echo "🎉 Pipeline completed successfully!" }
        failure { echo "❌ Build or tests failed. Check console output." }
        always { echo "📝 Pipeline finished. Review stages and test results above." }
    }
}