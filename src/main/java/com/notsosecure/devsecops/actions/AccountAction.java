package com.notsosecure.devsecops.actions;

import org.apache.struts2.interceptor.validation.SkipValidation;

import com.notsosecure.devsecops.dao.manager.IUserManager;
import com.notsosecure.devsecops.dao.manager.impl.UserManager;
import com.notsosecure.devsecops.model.UserType;
import com.notsosecure.devsecops.model.Users;
import com.notsosecure.devsecops.util.Validator;

public class AccountAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6364191264758542061L;
	private String name;
	private String email;
	private String userType=" ";
	private String password;
    private String message;

	private Users user;

	private IUserManager userManager = new UserManager();

	@SkipValidation
	public String accountView() {
		 Users user = (Users) sessionMap.get(USER_HANDLE);
		 name=user.getName() ;
		 email=user.getEmail();
		 password="";
		return SUCCESS;
	}

	@Override
	public void validate() {
		if (Validator.isEmpty(name))
			addFieldError("name", "please input name");
		if (Validator.isEmpty(email))
			addFieldError("email", "please input email");
		if (!Validator.isEmail(email))
			addFieldError("email", "please input valid email");
		if (Validator.isEmpty(password))
			addFieldError("password", "please input password");
	}

	@SkipValidation
	public String accountUpdate() {
		Users userSession = (Users) sessionMap.get(USER_HANDLE);
		user = new Users();
		user.setId(userSession.getId());
		user.setEmail(email);
		user.setPassword(password);
		user.setName(name);
		switch(userType){
		case " " :
			user.setUserType(UserType.USER);
			break ;
		case "user" :
			user.setUserType(UserType.USER);
			break;
		case "admin":
			user.setUserType(UserType.ADMIN);
			break;
		default:
			user.setUserType(UserType.USER);
			break;			
		}
		userManager.update(user);
		message="Your Profile has been Updated !";
		return SUCCESS;
	}
	
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
