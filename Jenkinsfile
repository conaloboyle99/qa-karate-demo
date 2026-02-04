// Jenkinsfile for qa-automation-demo
// This pipeline runs Karate tests (API & UI) in parallel, then Cypress tests, and archives results.

pipeline {
    agent any

    environment {
        KARATE_DIR = 'karate'      // Karate project folder
        CYPRESS_RESULTS_DIR = 'results/cypress' // Cypress results folder
    }

    stages {

        // ----------------------
        // 1. Basic pipeline check
        // ----------------------
        stage('Pipeline Check') {
            steps {
                echo "✅ Jenkins pipeline is running!"
            }
        }

        // ----------------------
        // 2. Checkout the repo
        // ----------------------
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        // ----------------------
        // 3. Run Karate Tests in Parallel
        // ----------------------
        stage('Run Karate Tests (Parallel)') {
            parallel {

                stage('Karate API Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            echo "🏃 Running Karate API tests..."
                            sh './mvnw clean test -Dkarate.options="classpath:features/users.feature"'
                        }
                    }
                }

                stage('Karate UI Tests') {
                    steps {
                        dir("${KARATE_DIR}") {
                            script {
                                if (fileExists('src/test/resources/features/ui.feature')) {
                                    echo "🏃 Running Karate UI tests..."
                                    sh './mvnw clean test -Dkarate.options="classpath:features/ui.feature"'
                                } else {
                                    echo "⚠️ UI feature file not found, skipping UI tests."
                                }
                            }
                        }
                    }
                }

            }
        }

        // ----------------------
        // 4. Run Cypress Tests
        // ----------------------
        stage('Run Cypress Tests') {
            steps {
                echo "🏃 Running Cypress tests..."
                // Ensure Node and npm are visible to Jenkins
                withEnv(["PATH=/opt/homebrew/bin:$PATH"]) {
                    sh 'npm ci'
                    sh 'npx cypress run --reporter junit --reporter-options "mochaFile=results/cypress/results-[hash].xml"'
                }
            }
        }

        // ----------------------
        // 5. Archive Test Results
        // ----------------------
        stage('Archive Test Results') {
            steps {
                // Karate reports
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true

                // Cypress reports
                junit "${CYPRESS_RESULTS_DIR}/*.xml"
                archiveArtifacts artifacts: "${CYPRESS_RESULTS_DIR}/*.json, ${CYPRESS_RESULTS_DIR}/*.html", allowEmptyArchive: true
            }
        }

    } // end stages

    // ----------------------
    // Post-build actions
    // ----------------------
    post {
        success {
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed — check stage logs above."
        }
        always {
            echo "📝 Pipeline finished."
        }
    }

} // end pipeline