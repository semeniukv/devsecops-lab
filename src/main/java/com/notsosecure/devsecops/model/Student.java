package com.notsosecure.devsecops.model;

import java.io.Serializable;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Student implements Serializable {


	private static final long serialVersionUID = 4045291557686045738L;
	private String userName;
	private String firstName;
	private String lastName;
	private String password;
	private String emailAddress;
	private Date dateOfBirth;

	public Student(String string, String string2, String string3, String string4, String string5, String string6) {
		this.dateOfBirth=new Date();
		this.emailAddress=string5;
		this.password=string4;
		this.lastName=string3;
		this.firstName=string2;
		this.userName=string;
	}

	public Student() {
		// TODO Auto-generated constructor stub
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

}
