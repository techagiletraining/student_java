package com.training;

import com.training.repository.DataLoader;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class StudentJavaApplication {

	public static void main(String[] args) {
		ApplicationContext context = SpringApplication.run(StudentJavaApplication.class, args);
		DataLoader dataLoader = context.getBean(DataLoader.class);
		dataLoader.load();
	}
}
