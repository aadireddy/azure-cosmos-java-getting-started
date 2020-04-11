node{
    stage('scm checkout'){
       git 'https://github.com/aadireddy/azure-cosmos-java-getting-started.git'
    }
    stage('build'){
        def mvnHome = tool name: 'maven', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
    }
    stage('sonarqube'){
        def scannerHome = tool 'sonarqube'
        withSonarQubeEnv('sonarqube'){
        sh "${scannerHome}/bin/sonar-scanner"
        }
    }
   stage("Quality Gate"){
        sleep 180
          timeout(time: 2, unit: 'MINUTES') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
    stage('nexus artifacts'){
    nexusPublisher nexusInstanceId: '1234', nexusRepositoryId: 'releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/azure/target/azure-cosmos-java-getting-started-1.0-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'azure-cosmos-java-getting-started', groupId: 'com.azure', packaging: 'jar', version: '$BUILD_NUMBER']]]
    }
 }
