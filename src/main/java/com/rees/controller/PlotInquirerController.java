package com.rees.controller;

import com.rees.model.PlotInquirer;
import com.rees.model.User;
import com.rees.service.PlotInquirerService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/rees/admin/inquirer")
public class PlotInquirerController {

    @Autowired
    private PlotInquirerService service;

    @GetMapping
    public String showInquirerDashboard(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "secure/manageInquirer";
    }

    @GetMapping("/add")
    public String showAddInquirerForm(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "secure/addInquirer";
    }

    @PostMapping("/add")
    public String addInquirer(@RequestParam String name,
                              @RequestParam String phone,
                              @RequestParam String address,
                              RedirectAttributes redirectAttributes) {
        try {
            service.addInquirer(name, phone, address);
            redirectAttributes.addFlashAttribute("successMessage", "Inquirer added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add inquirer. Try again.");
        }
        return "redirect:/rees/admin/inquirer";
    }

    @GetMapping("/list")
    public String showInquirerList(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";

        List<PlotInquirer> inquirers = service.getAllInquirers();
        model.addAttribute("inquirers", inquirers);
        return "secure/listInquirer";
    }

    private boolean isAdmin(HttpSession session) {
        String email = (String) session.getAttribute("email");
        Object roleObj = session.getAttribute("role");

        User.Role role = null;
        if (roleObj instanceof String) {
            try {
                role = User.Role.valueOf((String) roleObj);
            } catch (IllegalArgumentException e) {
                return false;
            }
        } else if (roleObj instanceof User.Role) {
            role = (User.Role) roleObj;
        }

        return email != null && role == User.Role.ADMIN;
    }
}
