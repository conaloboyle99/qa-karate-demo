pipeline {
    agent any

    tools {
        jdk 'jdk17'
    }

    environment {
        KARATE_DIR = 'karate'
        BRANCH_NAME = 'cypress-pipeline-integration'
    }

    stages {

        stage('Pipeline Check') {
            steps {
                echo "✅ Jenkins pipeline is running on branch ${BRANCH_NAME}!"
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Run Tests in Parallel') {
            parallel {

                stage('Karate Tests') {
                    parallel {
                        stage('API Tests') {
                            steps {
                                dir("${KARATE_DIR}") {
                                    echo "🏃 Running Karate API tests..."
                                    sh './mvnw clean test -Dkarate.options="--tags @api"'
                                }
                            }
                        }
                        stage('UI Tests') {
                            steps {
                                dir("${KARATE_DIR}") {
                                    echo "🏃 Running Karate UI tests..."
                                    sh './mvnw clean test -Dkarate.options="--tags @ui"'
                                }
                            }
                        }
                    }
                }

                stage('Cypress Tests') {
                    steps {
                        echo "🏃 Running Cypress tests..."
                        sh 'npm run cypress:run-headless'
                    }
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                // Karate reports
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true

                // Cypress reports
                archiveArtifacts artifacts: "cypress/screenshots/**/*.*", allowEmptyArchive: true
                archiveArtifacts artifacts: "cypress/videos/**/*.*", allowEmptyArchive: true
            }
        }
    }

    post {
        success { echo "🎉 Pipeline completed successfully on branch ${BRANCH_NAME}!" }
        failure { echo "❌ Build or tests failed. Check console output." }
        always { echo "📝 Pipeline finished. Review stages and test results above." }
    }
}