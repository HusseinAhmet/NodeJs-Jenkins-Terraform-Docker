pipeline {
    agent {label 'ec2'}
tools {
  terraform 'terraform'
}
    stages {
        stage('Docker Image Build') {
            steps {
       
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 sh '''
                    docker build . -t hahmet2214/nodeapp:1.3
                    docker login -u "${USERNAME}" -p "${PASSWORD}"
                    docker push hahmet2214/nodeapp:1.3
                '''
                }

            }
         post {             
                 success {
                      slackSend color: 'good', message: 'Image push success '
                }
                failure {
                      slackSend color: 'bad', message: 'Image push failure '
                }
                
            }
        }
        stage('Create Infrastructure') {
            steps {
       
                
                 sh '''
                    cd Terraform/
                    terraform init 
                    terraform apply -var-file varValues.tfvars -auto-approve
                    echo "RDS_PASSWORD=$(terraform output db_instance_password)" >> rdsenv.txt
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*b1 ' line='  HostName $(terraform output -raw jumpbox-pubIP)' "
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*s1 ' line='  HostName $(aws ec2 describe-instances --region eu-west-3 --filters "Name=subnet-id,Values=$(terraform output priv-sub-1-id ) " --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)' "                
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*s2 ' line='  HostName $(aws ec2 describe-instances --region eu-west-3 --filters "Name=subnet-id,Values=$(terraform output priv-sub-2-id ) " --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)' "

                '''
                

            }
         post {             
                 success {
                      slackSend color: 'good', message: 'Create Infrastructure success '
                }
                failure {
                      slackSend color: 'bad', message: 'Create Infrastructure failure '
                    sh """
                      cd Terraform/ 
                      terraform destroy -var-file varValues.tfvars -auto-approve
                      """
                }
                
            }
        }
        stage('Configure Servers & Deploy ') {
            steps {
       
                
                 sh """

                    ansible-playbook priv-server.yml -i inventory.txt --private-key /home/ubuntu/train-key.pem 
                """
                

            }
         post {             
                 success {
                      slackSend color: 'good', message: 'Deploy success '
                }
                failure {
                      slackSend color: 'bad', message: 'Deploy failure '
                      sh """
                      cd Terraform/ 
                      terraform destroy -var-file varValues.tfvars -auto-approve
                      """
                      
                }
                
            }
        }

    }
}
