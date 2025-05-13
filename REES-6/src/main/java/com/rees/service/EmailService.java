package com.rees.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@Component
public class EmailService {
	 @Autowired
	    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Value("${spring.mail.password}")
    private String password;

    // General method to send an email
    public boolean sendEmail(String to, String subject, String messageText) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");  
        props.put("mail.smtp.port", "587");             
        props.put("mail.smtp.auth", "true");             
        props.put("mail.smtp.starttls.enable", "true"); 

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to send welcome email with the temporary password
    public boolean sendWelcomeEmail(String name, String email, String password) {
        String subject = "Welcome to REES";
        String messageText = "Hello " + name + ",\n\nYour account has been created successfully.\n" +
                             "Yourpassword is: " + password +
                             "\n\n\nRegards,\nREES Team";
        return sendEmail(email, subject, messageText);
    }

    public boolean sendResetEmail(String name, String email, String newPassword) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("REES - Password Reset");
            message.setText("Hello " + name + ",\n\nYour password has been reset.\n" +
                            "New Password: " + newPassword +
                            "\nPlease login and change it immediately.\n\n" +
                            "Regards,\nREES Support");
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}