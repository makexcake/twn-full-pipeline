pipeline {

    agent any
    tools {
        //NOTE: must have node plugin installed
        nodejs "node"
    }

    stages {

        //init stage
        stage('init') {
            steps {
                echo "initialising..." 
            }
        }

        //increase version
        stage('version increment') {
            steps {
                echo "increasing version..."

                script {
                    //call increase version script and export version to env vars
                    sh './increaseVersion.sh patch'
                    env.BUILD_VERSION = sh(returnStdout: true, script: "./readVersion.sh")
                    env.IMAGE_NAME = '''java-mysql-app:${BUILD_VERSION}'''
                }   
            }
        }
        

        //build
        stage('build app') {
            steps {
                echo "building app..."     

                script {
                    sh './gradlew build'
                }               
            }
        }


        //test
        stage('test') {
            steps {
                echo "testing..."
            }
        }


        //build image and push to repo
        stage('build image') {
            steps {
                echo "pushing to ecr"
                
                script {

                    
                    sh "cat Dockerfile"
                    sh "aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 536167534320.dkr.ecr.eu-central-1.amazonaws.com"
                    //docker build -t nodejs-server  --build-arg UBUNTU_VERSION=18.04 --build-arg CUDA_VERSION=10.0
                    sh "docker build -t ${IMAGE_NAME} --build-arg appver=${BUILD_VERSION} ."
                    sh "docker tag ${IMAGE_NAME} 536167534320.dkr.ecr.eu-central-1.amazonaws.com/${IMAGE_NAME}"
                    sh "docker push 536167534320.dkr.ecr.eu-central-1.amazonaws.com/${IMAGE_NAME}"
                }
            }
        }


        //commit version update in git repo
        stage('commit') {
            steps {
                echo "comitting to git..."
                
            }
        }
    } 
}