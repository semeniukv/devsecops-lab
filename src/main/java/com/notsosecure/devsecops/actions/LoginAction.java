package com.notsosecure.devsecops.actions;


import org.apache.struts2.interceptor.validation.SkipValidation;

import com.notsosecure.devsecops.dao.manager.IUserManager;
import com.notsosecure.devsecops.dao.manager.impl.UserManager;
import com.notsosecure.devsecops.model.UserType;
import com.notsosecure.devsecops.model.Users;
import com.notsosecure.devsecops.util.Validator;

public class LoginAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 6364191264758542061L;
	private String name;
    private String email;
    private String password;

    private Users user;

    private IUserManager userManager = new UserManager();


    @SkipValidation
    public String view() {
        return SUCCESS;
    }

    @Override
    public void validate() {
        if (Validator.isEmpty(name)) addFieldError("name", "please input name");
        if (Validator.isEmpty(email)) addFieldError("email", "please input email");
        if (!Validator.isEmail(email)) addFieldError("email", "please input valid email");
        if (Validator.isEmpty(password)) addFieldError("password", "please input password");
    }


    public String register() {
        user = new Users();
        user.setEmail(email);
        user.setPassword(password);
        user.setName(name);
        user.setUserType(UserType.USER);
        userManager.create(user);
        return SUCCESS;
    }

    @SkipValidation
    public String login() {
        user = userManager.getUserByEmailAndPassword(email, password);
        if (user != null) {
            sessionMap.put(USER_HANDLE, user);
            if (user.getUserType() == UserType.ADMIN) return "admin";
            if (user.getUserType() == UserType.USER) return "user";
        }
        return INPUT;
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
}
