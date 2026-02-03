pipeline {
    agent any

    tools {
        jdk 'jdk17'
    }

    environment {
        KARATE_DIR = 'karate'
        REPORTS_DIR = 'reports'
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
                        echo "🏃 Running API tests..."
                        sh 'chmod +x mvnw'
                        sh './mvnw -f pom.xml clean test -Dkarate.options="--tags @api"'
                    }
                    post {
                        always {
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                }
                stage('UI Tests') {
                    steps {
                        echo "🏃 Running UI tests..."
                        sh 'chmod +x mvnw'
                        sh './mvnw -f pom.xml clean test -Dkarate.options="--tags @ui"'
                    }
                    post {
                        always {
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                }
            }
        }

        stage('Archive Reports') {
            steps {
                echo "📂 Archiving Karate HTML reports..."
                archiveArtifacts artifacts: "${REPORTS_DIR}/**/*", allowEmptyArchive: true
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