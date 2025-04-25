package com.rees.controller;

import com.rees.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @GetMapping("/adminDashboard")
    public String showAdminDashboard(HttpSession session) {
        if (session.getAttribute("email") == null) {
            return "redirect:/";
        }

        User.Role role = (User.Role) session.getAttribute("role");

        if (role != User.Role.ADMIN) {
            return "redirect:/dashboard";
        }

        return "adminDashboard";
    }
}
