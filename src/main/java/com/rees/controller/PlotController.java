package com.rees.controller;

import com.rees.dto.PlotDTO;
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
@RequestMapping("/rees/admin/plots")
public class PlotController {

    @Autowired
    private PlotService plotService;

    @Autowired
    private ProjectService projectService; // returns ProjectDTO list via its existing method

    @GetMapping
    public String showPlotPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "secure/managePlots";
    }

    @GetMapping("/add")
    public String showAddPlotForm(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        model.addAttribute("plot", new PlotDTO());
        model.addAttribute("projects", projectService.getAllProjects()); // existing method supplies ProjectDTO list
        return "secure/addPlot";
    }

    @PostMapping("/add")
    public String savePlot(@ModelAttribute("plot") PlotDTO plotDto, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        try {
            plotDto.setStatus("AVAILABLE");
            plotService.addPlot(plotDto);
            model.addAttribute("message", "Plot added successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error adding plot: " + e.getMessage());
        }

        model.addAttribute("plot", new PlotDTO());
        model.addAttribute("projects", projectService.getAllProjects());
        return "secure/addPlot";
    }

    @GetMapping("/list")
    public String viewPlots(@RequestParam(value = "projectId", required = false) Integer projectId,
                            HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        try {
            model.addAttribute("projects", projectService.getAllProjects());

            List<PlotDTO> plots;
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

        return "secure/listPlot";
    }

    @GetMapping("/edit")
    public String showEditPlotFormGet(@RequestParam("plotId") int plotId, HttpSession session, Model model) throws Exception {
        if (!isAdmin(session)) return "redirect:/";

        PlotDTO plot = plotService.getPlotById(plotId);
        if (plot == null) {
            model.addAttribute("error", "Plot not found");
            return "redirect:/rees/admin/plots/list";
        }
        model.addAttribute("plot", plot);
        model.addAttribute("projects", projectService.getAllProjects());

        return "secure/editPlot";
    }

    @PostMapping("/update")
    public String updatePlot(@ModelAttribute("plot") PlotDTO plotDto, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        try {
            plotService.updatePlot(plotDto);
            model.addAttribute("message", "Plot updated successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating plot: " + e.getMessage());
        }

        model.addAttribute("plot", plotDto);
        model.addAttribute("projects", projectService.getAllProjects());
        return "secure/editPlot";
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
