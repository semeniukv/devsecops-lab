package com.notsosecure.devsecops.actions;

import java.util.Properties;

public class ContactAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = -2008122727483505394L;
	private String name;
    private String email;
    private String subject;
    private String message;

    public String viewContact() {
        return SUCCESS;
    }

    public String sendEmail() {
        String finalMessage="";
        sendEmail(subject, finalMessage);
        return SUCCESS;
    }


    private void sendEmail(String subject, String strMessage) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
//
//        Session session = Session.getDefaultInstance(props,
//                new javax.mail.Authenticator() {
//                    protected PasswordAuthentication getPasswordAuthentication() {
//                        return new PasswordAuthentication("assetsys777@gmail.com", "777assetsys");
//                    }
//                });
//
//        try {
//
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress("sevakmart@gmail.com"));
//            message.setRecipients(Message.RecipientType.TO,
//                    InternetAddress.parse("sevakmart@gmail.com"));
//            message.setSubject(subject);
//            message.setText(strMessage);
//
//            Transport.send(message);
//
//            System.out.println("Done");
//
//        } catch (MessagingException e) {
//            throw new RuntimeException(e);
//        }
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
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
}
