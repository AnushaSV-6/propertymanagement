package com.rees.controller;

import com.rees.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/rees/forgot")
    public String showForgotPage() {
        return "public/forgotPassword"; 
    }
    @GetMapping("/loginPage")
    public String showLoginPage() {
        return "public/login";
    }

    @PostMapping("/forgotPass")
    public String handleForgot(@RequestParam("email") String email, HttpServletRequest request) {
        String resultMessage = userService.resetPassword(email);

        if (resultMessage.startsWith("New Password has been sent")) {
            request.setAttribute("successMessage", resultMessage);
        } else {
            request.setAttribute("errorMessage", resultMessage);
        }

        return "public/forgotPassword"; // JSP page
    }
}
