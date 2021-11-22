package com.notsosecure.devsecops.actions.api;

import java.beans.XMLDecoder;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.notsosecure.devsecops.model.Student;
import com.notsosecure.devsecops.service.StudentService;
import com.opensymphony.xwork2.ActionSupport;

public class StudentAddApi extends ActionSupport implements ServletResponseAware, ServletRequestAware {

	private static final long serialVersionUID = -7110896871635652942L;
	private ServletInputStream xmlString;
	protected HttpServletRequest servletRequest;
	protected HttpServletResponse servletResponse;
	DateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");

//	VULNERABLE CODE
//	@Action("/api/add")
	public String execute() throws Exception {
		System.out.println("Inside Student Add");
		StudentService studentService = new StudentService();
		xmlString = servletRequest.getInputStream();
		XMLDecoder xmlDecoder = new XMLDecoder(xmlString);
		Student student = (Student) xmlDecoder.readObject();
//		Student student = new Student("test","test","test","test","test","test@test.com");
//		System.out.println(student.getFirstName());
		String result;
		result=studentService.save(student.getUserName(), student.getPassword(), student.getFirstName(), student.getLastName(),
				dateFormat.format(student.getDateOfBirth()), student.getEmailAddress());
		PrintWriter printWriter = servletResponse.getWriter();
		switch (result) {
		case "SignupFailure-UserNameExists":
			printWriter.println("Username Exists");
			break;
		case "SignupSuccess":
			printWriter.println("Users Added Successfully");
			break;
		case "SignupFailure":
			printWriter.println("Something Went wrong");
			break;
		default:
			break;
		}

		return NONE;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.servletRequest = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.servletResponse = response;
	}

}
