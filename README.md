# student_java #

A Java Spring Boot app leveraging REST to serve data from a MySQL database.  Spring Data JPA provides the data integration framework.

# Development

This project contains everything necessary to build and run the project with the exception of Java.  Be sure to install Java 8 +. This project leverage Gradle to manage dependencies and execute basic compile, build, test and run commands. 

`./gradlew assemble` to compile and build the java artifact

`./gradlew test` to execute the unit test

`./gradlew bootrun` to start the app

By default the application starts on Port 8080 and can be accessed at `localhost:8080/`
