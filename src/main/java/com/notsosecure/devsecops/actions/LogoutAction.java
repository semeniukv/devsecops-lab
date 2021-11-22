package com.notsosecure.devsecops.actions;

public class LogoutAction extends BaseAction {

	   /**
	 * 
	 */
	private static final long serialVersionUID = -7742732633597749508L;

	@Override
	    public String execute() throws Exception {
	        invalidate();
	        return SUCCESS;
	    }
	
}
