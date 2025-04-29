package com.rees.controller;

import com.rees.model.Plot;
import com.rees.model.User;
import com.rees.service.PlotService;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/plots")
public class PlotController {

	 @Autowired
	    private PlotService plotService;  

    @GetMapping
    public String showManagePlotPage(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "managePlot";
    }
    @GetMapping("/viewplot")
    public String viewPlot(Model model) {
        try {
            List<Plot> plots = plotService.getAllPlots();
            model.addAttribute("plots", plots); // now correct variable name
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load plots");
            e.printStackTrace();
        }
        return "viewPlots";
    }
}