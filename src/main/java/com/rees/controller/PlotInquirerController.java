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
@RequestMapping("/admin/inquirer")
public class PlotInquirerController {

    @Autowired
    private PlotInquirerService service;

    
    @GetMapping
    public String showInquirerPage(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        // Redirect if not logged in or not admin
        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "manageInquirer";  
    }

        

    @PostMapping("/add")
    public String addInquirer(@RequestParam String name,
                              @RequestParam String phone,
                              @RequestParam String address,
                              RedirectAttributes redirectAttributes) {
        try {
            service.addInquirer(name, phone, address);
            String message = "Inquirer added successfully: " + name + " (" + phone + ") from " + address;
            redirectAttributes.addFlashAttribute("successMessage", message);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Unable to store inquirer. Please try again.");
        }
        return "redirect:/admin/inquirer";
    }

}
