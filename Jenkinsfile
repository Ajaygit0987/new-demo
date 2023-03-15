pipeline {
    agent any
	
	  tools
    {
       maven "MAVEN"
    }
  environment {
        registry = "acct_id.dkr.ecr.us-east-2.amazonaws.com/your_ecr_repo"
    }

 stages {
      stage('checkout') {
           steps {
             
                git branch: 'master', url: 'https://github.com/Ajaygit0987/new-demo.git'
             
          }
        }
	 stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }
 stage('Static code analysis'){
            
            steps{
                
                
                     withSonarQubeEnv(credentialsId: 'sonar-api') 
                        
                        sh 'mvn clean package sonar:sonar'
                    
                   
                    
                }
            }
stage ('upload war file to nexus'){

             steps{

                 nexusArtifactUploader artifacts:
                 artifactid: 'springboot" classifier:
                 "*, file: 'target/Uber. jar',
                 type: jar'
                 credentialsid: "nexus -auth groupid:
                 "con, example nexusUri: 13.226,244.16:8081° nexusVersions"nexuss?
                 protocol: 'http repository: "demoapp-release* version:
                 1.0.0
}
}
        

  stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t samplewebapp:latest .' 
                sh 'docker tag samplewebapp:latest ajaydocker0987/samplewebapp:latest'
                //sh 'docker tag samplewebapp ajaydocker0987/samplewebapp:$BUILD_NUMBER'
               
          }
        }
     
   stage('Pushing to ECR') {
     steps{  
         script {
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin acct_id.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker push acct_id.dkr.ecr.us-east-2.amazonaws.com/samplewebapp:latest'
         }
        }
      }
     stage('continous testing'){
            steps{
             git 'https://github.com/intelliqittrainings/FunctionalTesting.git'
                 sh 'java -jar /var/lib/jenkins/workspace/declarative_pipeline/testing.jar'
            }
            
        }
      
   stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh 'aws eks update-kubeconfig --name myapp-eks-cluster'
                        sh 'kubectl apply -f nginx-deployment.yaml'
                        sh 'kubectl apply -f nginx-service.yaml'
                    }
                }
            }
        }
        
 
    }
}
 
