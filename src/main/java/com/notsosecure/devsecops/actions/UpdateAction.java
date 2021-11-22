package com.notsosecure.devsecops.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.notsosecure.devsecops.service.StudentService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import com.opensymphony.xwork2.validator.annotations.StringLengthFieldValidator;
import com.opensymphony.xwork2.validator.annotations.ValidatorType;

public class UpdateAction extends ActionSupport implements ServletResponseAware, ServletRequestAware{

	private static final long serialVersionUID = -8955937840642685301L;

	private String pageName;
	private String userName;
	private String firstName;
	private String lastName;
	private String dateOfBirth;
	private String emailAddress;
	
	protected HttpServletRequest servletRequest;
	protected HttpServletResponse servletResponse;
	
//	@Action("update-input")
	public String input() throws Exception {
		System.out.println("input() in SignupAction");
		return "update";
	}

	@Override
//	@Action(value = "update", results = { @Result(name = "update-input", location = "update-input", type = "redirect") })
	public String execute() throws Exception {
		System.out.println("execute() in SignupAction");
		String result = "";
		StudentService studentService = new StudentService();
		System.out.println(pageName);
		if (pageName != null && studentService != null) {
			if (pageName.equals("update")) {
					studentService.update(userName, firstName, lastName, dateOfBirth, emailAddress);
				System.out.println(result);
				if (result.equals("SignupSuccess")) {
					return "login-input";
				} else {
					return "failure";
				}
			}
		}
		return SUCCESS;
	}
	
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.servletRequest=request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.servletResponse=response;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getUserName() {
		return userName;
	}

	@RequiredStringValidator(type = ValidatorType.FIELD, message = "UserName is a required field")
	@StringLengthFieldValidator(type = ValidatorType.FIELD, maxLength = "12", minLength = "3", message = "UserName must be of length between 3 and 12")
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFirstName() {
		return firstName;
	}

	@RequiredStringValidator(type = ValidatorType.FIELD, message = "FirstName is a required field")
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	@RequiredStringValidator(type = ValidatorType.FIELD, message = "LastName is a required field")
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	@RequiredStringValidator(type = ValidatorType.FIELD, message = "DateOfBirth is a required field")
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	
	public String getEmailAddress() {
		return emailAddress;
	}

	@RequiredStringValidator(type = ValidatorType.FIELD, message = "EmailAddress is a required field")
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

}
