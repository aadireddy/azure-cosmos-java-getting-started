node{
    stage('scm checkout'){
       git 'https://github.com/aadireddy/azure-cosmos-java-getting-started.git'
    }
    stage('build'){
        def mvnHome = tool name: 'maven', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
    }
    stage('nexus artifacts'){
    nexusPublisher nexusInstanceId: '1234', nexusRepositoryId: 'releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/azure/target/azure-cosmos-java-getting-started-1.0-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'azure-cosmos-java-getting-started', groupId: 'com.azure', packaging: 'jar', version: '$BUILD_NUMBER']]]
    }
    stage('build docker image'){
        sh 'docker build -t aadireddy/azure:$BUILD_NUMBER .'
    }
    stage('push docker image'){
        withCredentials([string(credentialsId: 'hub-pwd', variable: 'hub_pwd')]) {
        sh 'docker login -u aasireddy -p ${hub_pwd}'
    }
        sh 'docker push 'aadireddy/azure:$BUILD_NUMBER'
    }
    stage('update image version'){
        sh label: '', script: '''sed -i s/latest/$BUILD_NUMBER/ azzure-deploy.yml'''    
    }
    stage('deploy to kubernetes'){
        kubernetesDeploy(
        configs: 'devcenter-deploy.yml',
        kubeconfigId: 'k8s_config',
        enableConfigSubstitution: true
        )
    }
 }
