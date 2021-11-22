package com.notsosecure.devsecops.service;

import java.util.List;

import com.notsosecure.devsecops.model.Student;
import com.notsosecure.devsecops.respository.StudentRepository;

public class StudentService {

	private StudentRepository studentRepository;

	public StudentService() {
		studentRepository = new StudentRepository();
	}

	public String save(String userName, String password, String firstName, String lastName, String dateOfBirth,
			String emailAddress) {
		if (studentRepository != null) {
			if (studentRepository.findByUserName(userName)) {
				return "SignupFailure-UserNameExists";
			}
			studentRepository.save(userName, password, firstName, lastName, dateOfBirth, emailAddress);
			return "SignupSuccess";
		} else {
			return "SignupFailure";
		}
	}

	public String findByLogin(String userName, String password) {
		String result = "LoginFailure";
		if (studentRepository != null) {
			boolean status = studentRepository.findByLoginSQL(userName, password);
//			boolean status = studentRepository.findByLogin(userName, password);
			if (status) {
				result = "LoginSuccess";
			}
		}
		return result;
	}

	public List<Student> studentList(){
		return studentRepository.list();
	}

	public void update(String userName, String firstName, String lastName, String dateOfBirth, String emailAddress) {
		studentRepository.update(userName, firstName, lastName, dateOfBirth, emailAddress);
	}

	public Student fetchUserDetails(String userName) {
		return studentRepository.fetchUserDetails(userName);
	}
}
