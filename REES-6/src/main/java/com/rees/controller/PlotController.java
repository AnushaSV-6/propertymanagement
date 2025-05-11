package com.rees.controller;

import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.User;
import com.rees.service.PlotService;
import com.rees.service.ProjectService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/plots")
public class PlotController {

    @Autowired
    private PlotService plotService;

    @Autowired
    private ProjectService projectService;

    @GetMapping
    public String showPlotPage(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "managePlots";
    }

    @GetMapping("/add")
    public String showAddPlotForm(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        model.addAttribute("plot", new Plot());
        model.addAttribute("projects", projectService.getAllProjects());

        return "addPlot";
    }

    @PostMapping("/add")
    public String savePlot(@ModelAttribute Plot plot, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            plot.setStatus(Plot.PlotStatus.AVAILABLE);
            plotService.addPlot(plot);
            model.addAttribute("message", "Plot added successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error adding plot: " + e.getMessage());
        }

        model.addAttribute("plot", new Plot()); // reset form
        model.addAttribute("projects", projectService.getAllProjects());
        return "addPlot";
    }

    @PostMapping("/edit")
    public String showEditPlotForm(@RequestParam("plotId") int plotId, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            Plot plot = plotService.getPlotById(plotId);
            model.addAttribute("plot", plot);
            model.addAttribute("projects", projectService.getAllProjects());
        } catch (Exception e) {
            model.addAttribute("error", "Error loading plot: " + e.getMessage());
        }

        return "editPlot";
    }


    @PostMapping("/update")
    public String updatePlot(@ModelAttribute Plot plot, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            plotService.updatePlot(plot);
            model.addAttribute("message", "Plot updated successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating plot: " + e.getMessage());
        }

        model.addAttribute("plot", plot);
        model.addAttribute("projects", projectService.getAllProjects());
        return "editPlot";
    }

    @GetMapping("/list")
    public String viewPlots(@RequestParam(value = "projectId", required = false) Integer projectId,
                            HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            // Fetch all projects for the dropdown
            List<Project> projects = projectService.getAllProjects();
            model.addAttribute("projects", projects);

            List<Plot> plots;
            // If projectId is selected, filter by projectId, otherwise fetch all plots
            if (projectId != null) {
                plots = plotService.getPlotsByProjectId(projectId);
                model.addAttribute("selectedProjectId", projectId);
            } else {
                plots = plotService.getAllPlots();
            }

            model.addAttribute("plots", plots);
        } catch (Exception e) {
            model.addAttribute("error", "Error loading plots: " + e.getMessage());
        }

        return "listPlot";  // Or your desired JSP name
    }
}