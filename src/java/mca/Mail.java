package mca;

import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Divya Kumar Jain
 */
//This Mail class only for the send the eamil to the faculty registration for send to their id and password for the login credentials
public class Mail {

    public boolean sendEmail(String recipient, String subject, String content) {
        final String username = "jaindivya9649@gmail.com";
        final String password = "luhw ffac qelo hgxv";
        boolean emailSent = false;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username,"CHARUSAT"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject(subject);
            message.setContent(content, "text/html");

            Transport.send(message);
            emailSent = true;

            System.out.println("Email sent successfully.");
        } catch (MessagingException e) {
            System.out.println("Error in sending email: " + e.getMessage());
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return emailSent;
    }

//    public boolean sendEmail(String recipient, String Fullname, String userid, String faculty_password) {
//        // Set up the authentication information
//        final String username = "jaindivya9649@gmail.com";
//        final String password = "luhw ffac qelo hgxv";
//        //luhw ffac qelo hgxv
//        boolean emailSent = false; // Flag to track if the email was sent successfully
//
//        // Set up the mail server properties
//        Properties props = new Properties();
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.port", "465");
////        props.put("mail.smtp.ssl.enable", "true");
//        props.put("mail.smtp.socketFactory.port", "465");
//        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//        // Create a session with the authentication information
//        Session session = Session.getInstance(props, new Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(username, password);
//            }
//        });
//        try {
//            // Create a new message
//            MimeMessage message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(username, "CHARUSAT")); // Set the sender's email address
//            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); // Set the recipient's email address
//            message.setSubject("Your Registration Successfully"); // Set the email subject
//
//            // Set the email content as HTML
//            String content = "<h3>Dear " + Fullname + "</h3>"
//                    + "<p style='font-size: 16px'>Your Login Id is : <b>" + userid + "</b><br>"
//                    + "password is : <b>" + faculty_password + "</b></p>"
//                    + "<a href='http://localhost:8080/mcaproject/' style='padding: 10px; text-decoration: none; background-color: #007bff; color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>"
//                    + "Click here to open the portal</a>"
//                    + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
//                    + "<p style='font-size: 16px'><b style='color: red'>Note:</b>This is a system generated mail. Please do not reply to this mail.</p>"
//                    + "<h2>This is Login Credentials For " + Fullname + "</h2>";
//
//            message.setContent(content, "text/html");
//
//            Transport.send(message);
//            emailSent = true; // If sending is successful
//
//            System.out.println("Email sent successfully.");
//        } catch (MessagingException e) {
//            System.out.println("Error in sending ");
//        } catch (UnsupportedEncodingException ex) {
//            Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return emailSent;
//    }
}
