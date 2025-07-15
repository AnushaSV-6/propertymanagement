package com.rees.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Value("${app.email.welcome.subject}")
    private String welcomeSubject;

    @Value("${app.email.welcome.message}")
    private String welcomeMessage;

    @Value("${app.email.reset.subject}")
    private String resetSubject;

    @Value("${app.email.reset.message}")
    private String resetMessage;

    public boolean sendEmail(String to, String subject, String messageText) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(from);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(messageText);
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean sendWelcomeEmail(String name, String email, String password) {
        String body = welcomeMessage
                        .replace("{name}", name)
                        .replace("{password}", password);
        return sendEmail(email, welcomeSubject, body);
    }

    public boolean sendResetEmail(String name, String email, String newPassword) {
        String body = resetMessage
                        .replace("{name}", name)
                        .replace("{password}", newPassword);
        return sendEmail(email, resetSubject, body);
    }
}
