def label = "jenkins-agent-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'gcloud', image: 'google/cloud-sdk', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'dgcloud', image: 'paulwoelfel/docker-gcloud', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'gradle', image: 'dodb/jenkins-java-gradle-docker-slave', command: 'cat', ttyEnabled: true)
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {

	node(label) {
		stage('Setup') {
			PROJECT_ID = 'antigravity-techagile'
	    APP_NAME = 'student-java'
	    DOCKER_REPO = 'gcr.io'
	    CLUSTER_ID = 'techagile'
	    CLUSTER_ZONE = 'us-east1-b'
	    env.GIT_BRANCH_NAME = env.BRANCH_NAME.replace(/[#\/.]/, '-').trim()
			env.ts = System.currentTimeMillis()
			env.ARTIFACT = "app-${GIT_BRANCH_NAME}-${ts}.jar"
			env.IMAGE_NAME = "${DOCKER_REPO}/${PROJECT_ID}/${APP_NAME}/${GIT_BRANCH_NAME}:${ts}"

			container('gcloud') {
				sh 'echo begin setup'
				// set the kubectl context to the proper cluster
        withCredentials([file(credentialsId: 'jenkins-svc-acct', variable: 'serviceJson')]) {
					sh "gcloud auth activate-service-account --key-file=${serviceJson}"
        }
        sh "gcloud container clusters get-credentials $CLUSTER_ID --zone=$CLUSTER_ZONE"
				checkout scm
				sh 'echo end setup'
			}
		}

		stage('Build'){
			container('gradle') {
				sh './gradlew clean assemble'
			}
		}

		stage('Unit Test'){
			container('gradle') {
				sh './gradlew test'
			}
		}

		stage('Store Build Artifact'){
			container('dgcloud') {
				sh 'echo storing build artifact...'
				sh "mv build/libs/*.jar ${ARTIFACT}"
        sh "gsutil cp -R ${ARTIFACT} gs://techagile-build-distributions/"
			}
		}

		stage('Build Docker Image'){
			container('dgcloud') {
				sh 'echo publishing artifact...'
				sh "docker build -t ${IMAGE_NAME} --build-arg JAR_FILE=${ARTIFACT} ."
			}
		}

		stage('Publish Docker Image'){
			container('dgcloud') {
				sh 'echo publishing artifact...'
				sh "gcloud docker -- push ${IMAGE_NAME}"
			}
		}

		stage('Deploy'){
			container('dgcloud') {
				sh 'echo publishing artifact...'
			}
		}

		stage('Integration Test'){
			container('gradle') {
				sh 'echo publishing artifact...'
			}
		}
	}
}
