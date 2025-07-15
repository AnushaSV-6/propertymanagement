package com.rees.controller;

import com.rees.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Random;

@Controller
public class RegisterController {

    @Autowired
    private UserService userService;

    
    @GetMapping("/rees/register")
    public String showRegisterForm(HttpServletRequest request) {
        int captcha = new Random().nextInt(9000) + 1000;
        request.getSession().setAttribute("captcha_value", String.valueOf(captcha));
        return "public/register";  
    }

    
    @PostMapping("/register")
    public String register(HttpServletRequest request, HttpSession session, Model model) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

       
        String userCaptcha = request.getParameter("captcha");
        String sessionCaptcha = (String) session.getAttribute("captcha_value");

        if (sessionCaptcha == null || !sessionCaptcha.equals(userCaptcha)) {
            model.addAttribute("error", "CAPTCHA verification failed.");
            return "public/register";
        }

        
        String message = userService.registerUser(name, email, phone);
        model.addAttribute("message", message);

        return "secure/registerSuccess";  
    }
}
