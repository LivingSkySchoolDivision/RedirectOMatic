pipeline {
    agent any
    environment {
        REPO = 'web-external/redirectomatic'
        PRIVATE_REPO = "${PRIVATE_DOCKER_REGISTRY}/${REPO}"
        TAG = "${BUILD_TIMESTAMP}"
    }
    stages {
        stage('Git clone') {
            steps {
                git branch: 'master',
                    credentialsId: 'DEPLOY-KEY-JENKINS',
                    url: 'ssh://git@sourcecode.lskysd.ca:32123/Infrastructure/Redirectomatic.git'
            }
        }
        stage('Docker build') {
            steps {
                sh "docker build --no-cache -t ${PRIVATE_REPO}:latest -t ${PRIVATE_REPO}:${TAG} ."
            }
        }
        stage('Docker push') {
            steps {
                sh "docker push ${PRIVATE_REPO}:${TAG}"
                sh "docker push ${PRIVATE_REPO}:latest"           
            }
        }
    }
    post {
        failure {
            mail to:'jenkinsalerts@lskysd.ca',
                subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                body: "Something is wrong with ${env.BUILD_URL}"
        }
        success {
            mail to:'jenkinsalerts@lskysd.ca',
                subject: "Build pipeline completed successfully: ${currentBuild.fullDisplayName}",
                body: "${env.BUILD_URL}"
        }
        always {
            deleteDir()
        }
    }
}

