package com.rees.controller;

import com.rees.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserService userService;

    

  
@PostMapping("/forgot")
public String handleForgot(@RequestParam("email") String email, Model model) {
    String result = userService.resetPassword(email);

    if ("success".equals(result)) {
        model.addAttribute("successMessage", "A new password has been sent to your email.");
    } else if ("no_user".equals(result)) {
        model.addAttribute("errorMessage", "No account found with this email.");
    } else if ("email_failed".equals(result)) {
        model.addAttribute("errorMessage", "User found, but failed to send email.");
    }

    return "forgotPassword";
}
}
