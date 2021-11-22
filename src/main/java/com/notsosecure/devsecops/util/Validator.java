package com.notsosecure.devsecops.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validator {

	private static final String EMAIL_PATTERN =
			"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private static final String USERNAME_PATTERN = "[a-zA-Z0-9\\._\\-@]{3,12}"; 
	private static final String PASSWORD_PATTERN = "[a-zA-Z0-9\\._\\-]{8,12}"; 
	private static final String CONTENT_PATTERN = "[-\\w\\s]{1,280}"; 
	
	private static Pattern emailPattern;
	private static Matcher emailMatcher;
	private static Pattern usernamePattern;
	private static Matcher usernameMatcher;
	private static Pattern passwordPattern;
	private static Matcher passwordMatcher;
	private static Pattern contentPattern;
	private static Matcher contentMatcher;
	
	public static boolean validateEmail(final String email) {
		emailPattern=Pattern.compile(EMAIL_PATTERN);
		emailMatcher = emailPattern.matcher(email);
		return emailMatcher.matches();

	}
	
	public static boolean validateUsername(final String username) {
		usernamePattern=Pattern.compile(USERNAME_PATTERN);
		usernameMatcher = usernamePattern.matcher(username);
		boolean userName= usernameMatcher.matches();
		boolean email=validateEmail(username);
		return (userName || email);

	}
	
	
	public static boolean validatePassword(final String password) {
		passwordPattern=Pattern.compile(PASSWORD_PATTERN);
		passwordMatcher = passwordPattern.matcher(password);
		return passwordMatcher.matches();

	}	
	
	public static boolean validateContent(final String content) {
		contentPattern=Pattern.compile(CONTENT_PATTERN);
		contentMatcher = contentPattern.matcher(content);
		return contentMatcher.matches();

	}	
	
    public static boolean isEmpty(String value) {
        return value == null || "".equals(value);
    }

    public static boolean isEmail(String email) {
        Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public static boolean isNumber(String number) {
        try {
            int a = Integer.parseInt(number);
            return a > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
