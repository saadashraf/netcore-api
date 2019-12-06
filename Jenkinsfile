pipeline{
    agent any
    
    stages{
        stage('Restore'){
            steps{
                sh "dotnet restore"
            }
        }
        stage('Clean'){
            steps{
                sh "dotnet clean"
            }
        }
        stage('Build'){
            steps{
                sh "dotnet build"
            }
        }
        stage("Test")
        {
            when{
                branch "dev"
            }
            steps{
                sh "dotnet test -l 'trx;LogFileName=TestResults.trx'"
            }
        }
        stage("Running trx"){
            when{
                branch "dev"
            }
            steps{
                mstest testResultsFile:"**/*.trx", keepLongStdio: true
            }
        }
        stage('Publish'){
            steps{
                sh "dotnet publish -c release -o ./Output"
            }
        }

        stage('Application deploy'){
            when
            {
                branch "dev"
            }
            steps{
                sh "rsync -azvr /var/lib/jenkins/workspace/netcore-api_multibranch_dev/Output/ saadashraf@localhost:/home/saadashraf/Desktop/saadashraf/Work/Output/netcore-api-dev/"
            }
        }
        stage("Restart Daemon"){
            when
            {
                branch "dev"
            }
            steps{
                sh "ssh saadashraf@localhost sudo systemctl restart netcore-api_dev.service"
            }
        }
        
    }
}
