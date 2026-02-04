pipeline {
    agent any

    environment {
        KARATE_DIR = 'karate' // Directory containing Karate tests
    }

    stages {

        stage('Pipeline Check') {
            steps {
                /* Simple stage to verify Jenkins pipeline is running */
                echo "✅ Jenkins pipeline is running!"
            }
        }

        stage('Checkout Code') {
            steps {
                /* Pull the latest code from the configured SCM */
                checkout scm
            }
        }

        stage('Run Karate Tests (Parallel)') {
            parallel {

                stage('Karate API Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            /* Run API feature tests */
                            sh './mvnw clean' // Clean target to avoid duplicate file errors
                            sh './mvnw test -Dkarate.options="classpath:features/users.feature"'
                        }
                    }
                }

                stage('Karate UI Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            script {
                                /* Only run UI tests if the feature file exists */
                                if (fileExists('src/test/resources/features/ui.feature')) {
                                    echo "🏃 Running Karate UI tests..."
                                    sh './mvnw clean'
                                    sh './mvnw test -Dkarate.options="classpath:features/ui.feature"'
                                } else {
                                    echo "⚠️ UI feature file not found, skipping UI tests."
                                }
                            }
                        }
                    }
                }
            }
        }

        stage('Run Cypress Tests') {
            steps {
                /* Run front-end Cypress tests */
                echo "🏃 Running Cypress tests..."
                sh 'npm ci' // Install Node dependencies
                sh 'npx cypress run --reporter junit --reporter-options "mochaFile=results/cypress/results-[hash].xml"'
            }
        }

        stage('Archive Test Results') {
            steps {
                /* Save Karate test results */
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true

                /* Save Cypress test results */
                junit "results/cypress/*.xml"
                archiveArtifacts artifacts: "results/cypress/*.json, results/cypress/*.html", allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            /* Runs when the pipeline succeeds */
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            /* Runs when the pipeline fails */
            echo "❌ Pipeline failed — see stage logs above."
        }
        always {
            /* Runs no matter what, e.g., cleanup or notifications */
            echo "📝 Pipeline finished."
        }
    }
}