package com.notsosecure.devsecops.interceptor;

import java.util.Map;

import com.notsosecure.devsecops.model.Users;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthenticationInterceptor extends AbstractInterceptor {
    /**
	 * 
	 */
	private static final long serialVersionUID = 4164981686544696775L;

	@Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        Map<String, Object> session = actionInvocation.getInvocationContext().getSession();
        Users user = (Users) session.get("user");
        if (user == null) {
            return Action.LOGIN;
        }
        return actionInvocation.invoke();

    }
}
