package com.rees.controller;

import com.rees.model.Project;
import com.rees.model.User;
import com.rees.service.ProjectService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/projects")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @GetMapping
    public String showManageProjectPage(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "manageProject";
    }

   
    @GetMapping("/addproject")
    public String showAddProjectPage(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "addProject"; // /WEB-INF/views/addProject.jsp
    }

    
    @PostMapping("/save")
    public String saveProject(@ModelAttribute Project project, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            projectService.saveProject(project);
            model.addAttribute("message", "Project added successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error adding project: " + e.getMessage());
        }

        return "addProject";
    }
    
    @GetMapping("/viewProjects")
    public String viewProjects(Model model) {
        try {
            List<Project> projects = projectService.getAllProjects();
            model.addAttribute("projects", projects);
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load projects");
            e.printStackTrace();  // Print stack trace to debug the error
        }
        return "viewProjects";  // The name of the JSP file
    }




    
}