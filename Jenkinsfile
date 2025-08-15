pipeline {
    agent any

    environment {
        MYSQL_CREDENTIALS = credentials('MYSQL_ROOT') // Jenkins'te oluşturduğun credential ID
    }

    stages {
        stage('Checkout') {
            steps {
                // checkout scm kullanarak repo ve branch otomatik alınır
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/master']], // GitHub'daki branch
                          userRemoteConfigs: [[url: 'https://github.com/bernabaris/TestOps.git',
                                               credentialsId: 'github-berna']]])
            }
        }

        stage('Prepare DB') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'MYSQL_ROOT', passwordVariable: 'MYSQL_PASSWORD', usernameVariable: 'MYSQL_USER')]) {
                    sh 'mysql -h mysql-test -u $MYSQL_USER -p$MYSQL_PASSWORD < db-scripts/setup.sql'
                }

            }
        }

        stage('Run SoapUI Tests') {
            steps {
                sh '/home/jenkins/SoapUI-5.9.0/bin/testrunner.sh -s "TestSuite" -r -j -f reports/ soapui-tests/project.xml'
            }
        }

        stage('Collect Reports') {
            steps {
                allure includeProperties: false, jdk: '', results: [[path: 'reports']]
            }
        }

        stage('Notify') {
            steps {
                mail to: 'email@domain.com',
                     subject: "Jenkins Build ${currentBuild.fullDisplayName}",
                     body: "Build result: ${currentBuild.currentResult}"
            }
        }
    }
}
