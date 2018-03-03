node {
	stage 'Checkout'
	    checkout scm

	stage 'Build'
	    sh './gradlew assemble'

	stage 'Unit Test'
	    sh './gradlew test'

	stage 'Publish Unit Test Results'
	    sh 'echo not implemented'

	stage 'Integration Test'
	    sh 'echo not implemented'

	stage 'Deploy'
	    sh 'echo not implemented'
}