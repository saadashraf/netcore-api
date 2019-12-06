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
                sh "dotnet /var/lib/jenkins/workspace/netcore-api_multibranch_dev/Output/netcore-api.dll --urls='http://localhost:5001'"
            }
        }
        
    }
}
