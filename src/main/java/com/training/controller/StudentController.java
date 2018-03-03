package com.training.controller;

import com.training.entity.Student;
import com.training.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Created by chriscone on 9/11/17.
 */
@RestController
@RequestMapping("/student")
public class StudentController {

    private StudentRepository studentRepository;

    @Autowired
    public StudentController(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity getStudent(@PathVariable("id") int id) {
        return ResponseEntity.ok(studentRepository.findOne(id));
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ResponseEntity getAllStudents() {
        return ResponseEntity.ok(studentRepository.findAll());
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity addStudent(@RequestBody Student student) {
        return ResponseEntity.ok(studentRepository.save(student));
    }
}
