pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'  // Mumbai region
        DB_NAME = 'my-db'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/your-repo/rds-pipeline.git'
            }
        }

        stage('Create RDS Instance') {
            steps {
                sh '''
                aws rds create-db-instance \
                    --db-instance-identifier my-db-instance \
                    --db-instance-class db.t2.micro \
                    --engine mysql \
                    --allocated-storage 20 \
                    --master-username admin \
                    --master-user-password admin1234 \
                    --region $AWS_REGION
                '''
            }
        }

        stage('Insert Data into RDS') {
            steps {
                sh './store_data.sh'
            }
        }
    }
}
