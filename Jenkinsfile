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
                    aws ec2 describe-instances --region eu-west-3 --filters "Name=subnet-id,Values=$(terraform output priv-sub-2-id ) " --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text >> "${WORKSPACE}"/inventory.txt 
                    aws ec2 describe-instances --region eu-west-3 --filters "Name=subnet-id,Values=$(terraform output priv-sub-1-id ) " --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text >> "${WORKSPACE}"/inventory.txt 
                    echo "[nodes:vars] ">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_user=ubuntu ">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_port=22">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand=\"ssh -p 22 i /home/ubuntu/train-key -J ubuntu@$(terraform output jumpbox-pubIP)\"'   ">>  "${WORKSPACE}"/inventory.txt
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
