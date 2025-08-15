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
                sh "mysql -h mysql-test -u $MYSQL_CREDENTIALS_USR -p$MYSQL_CREDENTIALS_PSW < db-scripts/setup.sql"
            }
        }

        stage('Run SoapUI Tests') {
            steps {
                bat '"C:\\Program Files (x86)\\SmartBear\\SoapUI-5.5.0\\bin\\testrunner.bat" -s "TestSuite" -r -j -f reports/ soapui-tests/project.xml'
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
