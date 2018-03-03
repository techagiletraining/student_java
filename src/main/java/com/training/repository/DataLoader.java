package com.training.repository;

import com.training.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by chriscone on 9/11/17.
 */
@Component
public class DataLoader {

    private StudentRepository studentRepository;

    @Autowired
    public DataLoader(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public void load() {
        Student student1 = new Student();
        student1.setEmail("john.doe@mycompany.com");
        student1.setFirstName("John");
        student1.setLastName("Doe");

        Student student2 = new Student();
        student2.setEmail("bsmith@gmail.com");
        student2.setFirstName("Bob");
        student2.setLastName("Smith");


        studentRepository.save(student1);
        studentRepository.save(student2);
    }
}