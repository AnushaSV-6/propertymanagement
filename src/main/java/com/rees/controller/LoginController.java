package com.rees.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.rees.model.User;
import com.rees.service.*;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/rees/login")
    public String showLoginPage() {
        return "public/login"; // resolves to /WEB-INF/views/public/login.jsp
    }

    @PostMapping("/rees/login")
    public String login(@RequestParam("email") String email, @RequestParam("password") String password,
                        HttpSession session, Model model) {

        User userByEmail = userService.findByEmail(email);

        if (userByEmail == null) {
            model.addAttribute("errorMessage", "No account found with this email.");
            return "public/login";
        }

        if (userByEmail.getStatus() != User.Status.ACTIVE) {
            model.addAttribute("errorMessage",
                    "Your account is currently " + userByEmail.getStatus().name() + ". Please contact admin.");
            return "public/login";
        }

        boolean passwordMatch = userService.checkPassword(password, userByEmail.getPassword());
        if (!passwordMatch) {
            model.addAttribute("errorMessage", "Incorrect password. Please try again.");
            return "public/login";
        }

        session.setAttribute("email", userByEmail.getEmail());
        session.setAttribute("role", userByEmail.getRole().name());  // ✅ FIXED

        if (userByEmail.getRole() == User.Role.ADMIN) {
            return "secure/adminDashboard";
        } else {
            return "public/login"; }
    }
}
