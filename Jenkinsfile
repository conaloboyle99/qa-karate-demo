pipeline {
    agent any

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

        stage('Run Cypress Tests') {
            steps {
                echo "🏃 Running Cypress tests..."
                sh 'npm ci'
                sh 'npx cypress run --reporter junit --reporter-options "mochaFile=results/cypress/results-[hash].xml"'
            }
        }

        stage('Archive Test Results') {
            steps {
                // Karate reports
                junit "${KARATE_DIR}/target/surefire-reports/*.xml"
                archiveArtifacts artifacts: "${KARATE_DIR}/target/karate-reports/*.html", allowEmptyArchive: true

                // Cypress reports
                junit "results/cypress/*.xml"
                archiveArtifacts artifacts: "results/cypress/*.json, results/cypress/*.html", allowEmptyArchive: true
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