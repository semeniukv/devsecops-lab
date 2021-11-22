package com.notsosecure.devsecops.actions;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.notsosecure.devsecops.util.Validator;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware,ServletResponseAware,SessionAware,ApplicationAware {

	private static final long serialVersionUID = -3475615366384480246L;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Map<String, Object> sessionMap;
	protected static final String USER_HANDLE = "user";
	protected Validator strValidator = new Validator();
    protected Map<String, Object> applicationMap;
	
	public HttpServletRequest getRequest() {
		return request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response=response ;
		
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	

	public void setSession(Map<String, Object> session) {
		this.sessionMap=session;
	}
	
    void invalidate() {
    	sessionMap.clear();
    }

	@Override
	public void setApplication(Map<String, Object> application) {
		applicationMap=application ;
		
	}

	
}
