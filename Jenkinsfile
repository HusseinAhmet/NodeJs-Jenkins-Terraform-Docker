pipeline {
    agent any

    stages {
        stage('get') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 sh """
                    docker build . -f dockerfile -t hahmet2214/nodeapp:1.0
                    docker login -u ${USERNAME} -p ${PASSWORD} 
                    docker push hahmet2214/nodeapp:1.0
                """
                }
           

          

            }
         post {
            
                success {
                    sh"""
                    docker run -d -p 3000:3000 hahmet2214/nodeapp:1.0
                    """
                }
            }
        }
    }
}
