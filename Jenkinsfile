pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'maven:3.9.2-jdk-17'       // Docker image with Maven + JDK
        CONTAINER_NAME = 'karate-test-runner'    // Name of container we reuse
        WORKDIR = '/usr/src/app'                  // Path inside container where repo is mounted
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Get recent code from Git
            }
        }

        stage('Prepare Docker Container') {
            steps {
                script {
                    // Check if container already exists
                    def containerExists = sh(
                        script: "docker ps -a --format '{{.Names}}' | grep -w ${CONTAINER_NAME} || true",
                        returnStdout: true
                    ).trim()

                    if (containerExists) {
                        // If container exists but is stopped, start it
                        sh "docker start ${CONTAINER_NAME}"
                        echo "Reusing existing Docker container: ${CONTAINER_NAME}"
                    } else {
                        // Create new detached container if none exists
                        sh """
                        docker run -d --name ${CONTAINER_NAME} \
                            -v \$PWD:${WORKDIR} \
                            -w ${WORKDIR} \
                            ${DOCKER_IMAGE} tail -f /dev/null
                        """
                        echo "Created new Docker container: ${CONTAINER_NAME}"
                    }
                }
            }
        }

        stage('Run Karate Tests') {
            steps {
                // Run Maven tests inside the running container
                sh "docker exec ${CONTAINER_NAME} mvn clean test"
            }
        }
    }

    post {
        always {
            // Stop the container but keep for reuse
            sh "docker stop ${CONTAINER_NAME} || true"
            echo "Stopped container: ${CONTAINER_NAME}"

            // Clean up old containers (not the one we're using)
            sh """
            docker ps -a --format '{{.Names}}' | grep -v ${CONTAINER_NAME} | xargs -r docker rm -f || true
            """
            echo "Removed any old leftover Docker containers except ${CONTAINER_NAME}"
        }
    }
}