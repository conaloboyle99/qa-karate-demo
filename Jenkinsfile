pipeline {
    agent any

    tools {
        jdk 'jdk17'
        // ❌ NO nodejs tool — plugin not installed
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

        stage('Run Karate Tests (Parallel)') {
            parallel {

                stage('Karate API Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            echo "🏃 Running Karate API tests..."
                            sh './mvnw clean test -Dkarate.options="--tags @api"'
                        }
                    }
                }

                stage('Karate UI Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            echo "🏃 Running Karate UI tests..."
                            sh './mvnw clean test -Dkarate.options="--tags @ui"'
                        }
                    }
                }
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "🏃 Running Cypress tests..."
                sh 'npm ci'
                sh 'npx cypress run'
            }
        }

        stage('Archive Karate Results') {
            steps {
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed — see stage logs above."
        }
        always {
            echo "📝 Pipeline finished."
        }
    }
}