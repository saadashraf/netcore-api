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
            when{
                branch "master"
            }
            steps{
                sh "dotnet publish -c release -o ./Output"
            }
        }
        stage('Application deploy'){
            when
            {
                branch "master"
            }
            steps{
                sh "rsync -azvr /var/lib/jenkins/workspace/netcore-api_multibranch_master/Output/ saadashraf@localhost:/home/saadashraf/Desktop/saadashraf/Work/Output/netcore-api-master/"
            }
        }
        stage("Automating Service Creation"){
            when
            {
                branch "master"
            }
            steps{
                sh "ssh saadashraf@localhost sudo /home/saadashraf/Desktop/saadashraf/Work/Output/service_shell.sh /home/saadashraf/Desktop/saadashraf/Work/Output/netcore-api-master/service_master.json"
            }
        }
        
    }
}
