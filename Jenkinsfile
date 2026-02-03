pipeline {
    agent any

    // Use tools installed in Jenkins
    tools {
        jdk 'jdk17'           // Your configured JDK
    }

    environment {
        KARATE_DIR = 'karate'     // Relative path to Karate project
        REPORTS_DIRS = 'reports,karate/target/surefire-reports' // Comma-separated list of report folders
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
                    // Use Maven wrapper if present, fallback to system Maven
                    script {
                        if (fileExists('./mvnw')) {
                            sh './mvnw clean test'
                        } else {
                            sh 'mvn clean test'
                        }
                    }
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                script {
                    def dirs = REPORTS_DIRS.split(',')
                    dirs.each { reportDir ->
                        if (fileExists(reportDir)) {
                            echo "📂 Archiving test results from: ${reportDir}"
                            junit "${reportDir}/**/*.xml"
                        } else {
                            echo "⚠️ Report directory not found: ${reportDir}"
                        }
                    }
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