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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String showAddPlotForm(Model model, @RequestParam(value = "msg", required = false) String msg) throws Exception {
        model.addAttribute("plot", new Plot());
        model.addAttribute("projects", projectService.getAllProjects());
        model.addAttribute("msg", msg);
        return "addPlot";
    }

    @PostMapping("/add")
    public String savePlot(@ModelAttribute Plot plot, RedirectAttributes redirectAttributes) throws Exception {
        plot.setStatus(Plot.PlotStatus.AVAILABLE);
        plotService.addPlot(plot);
        redirectAttributes.addAttribute("msg", "Plot added successfully!");
        return "redirect:/admin/plots/add";
    }

    @GetMapping("/edit/{id}")
    public String showEditPlotForm(@PathVariable("id") int plotId, Model model, @RequestParam(value = "msg", required = false) String msg) throws Exception {
        Plot plot = plotService.getPlotById(plotId);
        model.addAttribute("plot", plot);
        model.addAttribute("projects", projectService.getAllProjects());
        model.addAttribute("msg", msg);
        return "editPlot";
    }

    @PostMapping("/update")
    public String updatePlot(@ModelAttribute Plot plot, RedirectAttributes redirectAttributes) throws Exception {
        plotService.updatePlot(plot);
        redirectAttributes.addAttribute("msg", "Plot updated successfully!");
        return "redirect:/admin/plots/edit/" + plot.getPlotId();
    }

    @GetMapping("/list")
    public String viewPlots(Model model) {
        try {
            List<Plot> plots = plotService.getAllPlots();
            model.addAttribute("plots", plots);
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load plots");
            e.printStackTrace();  // Print stack trace to debug the error
        }
        return "listPlot";  
    }
}
