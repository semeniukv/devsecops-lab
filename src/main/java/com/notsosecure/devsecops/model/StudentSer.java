package com.notsosecure.devsecops.model;

import java.io.Serializable;

public class StudentSer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7683023069705146732L;
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public StudentSer(String username) {
		super();
		this.username = username;
	}
	
}
