package com.rees.controller;

import com.rees.model.User;
import com.rees.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String showLoginPage() {
        return "index";
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {

        User userByEmail = userService.findByEmail(email);

       
        if (userByEmail == null) {
            model.addAttribute("errorMessage", "No account found with this email.");
            return "index";
        }

       
        if (userByEmail.getStatus() != User.Status.ACTIVE) {
            model.addAttribute("errorMessage", "Your account is currently " + userByEmail.getStatus().name() + ". Please contact admin.");
            return "index";
        }

        // 3. Password check using BCrypt
        boolean passwordMatch = userService.checkPassword(password, userByEmail.getPassword());
        if (!passwordMatch) {
            model.addAttribute("errorMessage", "Incorrect password. Please try again.");
            return "index";
        }

        // 4. Set session
        session.setAttribute("email", userByEmail.getEmail());
        session.setAttribute("role", userByEmail.getRole());

        // 5. Redirect based on role (enum comparison)
        if (userByEmail.getRole() == User.Role.ADMIN) {

            return "redirect:/adminDashboard";
        } else {
            System.out.println("Logged in user role: " + userByEmail.getRole());
            return "redirect:/dashboard";
        }
    }
}
