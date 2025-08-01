package com.rees.controller;

import com.rees.dto.UserDTO;
import com.rees.model.User.Role;
import com.rees.model.User.Status;
import com.rees.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/rees")
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "public/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpSession session, Model model) {

        UserDTO userByEmail = userService.findByEmail(email).orElse(null);

        if (userByEmail == null) {
            model.addAttribute("errorMessage", "No account found with this email.");
            return "public/login";
        }

        if (userByEmail.getStatus() != Status.ACTIVE) {
            model.addAttribute("errorMessage",
                    "Your account is currently " + userByEmail.getStatus().name() + ". Please contact admin.");
            return "public/login";
        }

        boolean passwordMatch = BCrypt.checkpw(password, userByEmail.getPassword());
        if (!passwordMatch) {
            model.addAttribute("errorMessage", "Incorrect password. Please try again.");
            return "public/login";
        }

        session.setAttribute("email", userByEmail.getEmail());
        session.setAttribute("role", userByEmail.getRole().name());

        if (userByEmail.getRole() == Role.ADMIN) {
            return "secure/adminDashboard";
        } else {
            return "secure/customerDashboard"; 
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/rees/login";
    }
}
