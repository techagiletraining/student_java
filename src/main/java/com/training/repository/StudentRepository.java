package com.training.repository;

import com.training.entity.Student;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by chriscone on 9/11/17.
 */
@Repository
public interface StudentRepository extends CrudRepository<Student, Integer> {

}
