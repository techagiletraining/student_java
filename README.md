# student_java #

A Java Spring Boot app leveraging REST to serve data from a MySQL database.  Spring Data JPA provides the data integration framework.

The idea behind this project is to introduce the concepts of XP, DevOps, site reliability and  modern software development best practices. The code and pipeline both leave room for improvement, which will be implemented as part of in class labs.

See something that you would like to add? Submit a pull request!

- Include notes / comments about what and why
- Good commit messages
- Test are a must, unless they are left off for a specific purpose

# Getting Started #

This project contains everything necessary to build and run the project with the exception of Java.  Be sure to install Java 8. This project leverages Gradle to manage dependencies and execute basic compile, build, test and run commands.

Take note of the Jenkinsfile.  This repository is hooked into an automated build pipeline, meaning that every push to the remote repo will trigger the steps in the Jenkinsfile including a deployment to a [kubernetes cluster](https://cloud.google.com/kubernetes-engine/docs/).

### Setup ###
**Note** This project requires Java 8 to compile. Check your java version and update it if necessary.

`java -version`

Update Java, be sure to select the java 8 opition in the alternatives step.
```
sudo yum install -y java-1.8.0-openjdk-devel
sudo alternatives --config java
sudo yum remove -y java-1.7.0-openjdk-devel```

Pull in the latest code.

`git clone https://github.com/techagiletraining/student_java.git`
`cd student_java`

The master branch is protected and does not allow direct commits, see the notes above on pull request, so each person needs to create a branch.  Naming recommendations are first letter of your first name and full last name. For example John Doe would be jdoe. This will ensure your branch name is compatible with the automated build pipeline. **Note** The branch name should not include any `_` and special characters should generally be avoided.

`git checkout -b jdoe`

Before making any changes, go ahead and push this branch to the remote repository and set the upstream.

`git push -u origin jdoe`

This should have trigger an automated build which can viewed on the  [Techagile Jenkins Server](http://jenkins.techagile.training:8080/), your instructor will provide credentials. More on Jenkins to come.

### Running the code ###
Compile and build the java artifact

`./gradlew assemble`

Start the app

`./gradlew bootrun`

By default the application starts on Port 8080 and can be accessed at `localhost:8080/`.  To ensure the app started properly navigate to [localhost:8080/student/1](localhost:8080/student/1) in your browser.

### Unit Test ###
A few unit test have been added to the project, they are by no means comprehensive.

To run the test

`./gradlew test`

To run the test with coverage

`./gradlew clean test jacocoTestReport`

Coverage reports can be found at `build/reports/jacoco`.

### Mutation Test ###
Mutation testing is done leveraging [pitest](http://pitest.org/) and can be kicked off with gradle.

`./gradlew pitest`

Coverage reports can be found at `build/reports/pitest`. Note that each test creates a folder named with the timestamp.

### Checkstyle ###
Checkstyle is using the [Google's Config](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml), though little has been done to ensure compliance.  In one of the labs, this will be hooked into the build process, causing the build to fail for any checkstyle errors.

`./gradlew checkstyleMain`

`./gradlew checkstyleTest`

Coverage reports can be found at `build/reports/checkstyle`.

### Integration Test ###
The integration test are executed using the [newman command line runner](https://www.getpostman.com/docs/v6/postman/collection_runs/command_line_integration_with_newman) for Postman collections.

To kickoff the test against the app running at localhost:8080, execute

`cd newman`

`./run.sh`

Or pass in a host argument to run the test against a remote application.

`./run.sh http://master.techagile.training`

### Jenkins & Kubernetes ###
This application is built using a [Jenkins](https://jenkins.io/) pipeline and deployed to a [Google Cloud Kubernetes](https://cloud.google.com/kubernetes-engine/docs/) cluster. The details for the setup of these components has been abstracted away from this code repo and will not be specifically covered here. Jenkins has been installed with Blue Ocean that provides are more user friendly experience, however not all functionality is available via Blue Ocean.

Access Jenkins

`http://jenkins.techagile.training:8080/`

Notice that each branch is listed under the student_java repo.  Each will be built, tested and deployed separately based on their branch name.

For example the jdoe branch will be deployed to an custom IP address that will be reported at the end of the Jenkins build following the Integration Test.

```
http://35.229.23.66
http://35.229.23.66/student/1
```

## Lab TODOs ##
- fail build checkstyle
- fail build code coverage
- fail build pitest coverage

## Random TODOs ##
- api documentation
- custom docker images for the Jenkins build
- publish test results for auditing
- create dns entry for newly deployed branches (this IP is exposed but the DNS entry can take up to 5 minutes)
