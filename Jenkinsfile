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
                mstest testResultsFile:"***/*.trx", keepLongStdio: true
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
        
    }
}
