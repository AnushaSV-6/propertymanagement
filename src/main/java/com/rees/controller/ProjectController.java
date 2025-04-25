package com.rees.controller;

import com.rees.model.Project;
import com.rees.model.User;
import com.rees.service.ProjectService;
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
        return "viewProjects";  
    }
   
    
    @GetMapping("/updateproject")
    public String showUpdateProjectForm(@RequestParam(value = "projectId", required = false) Integer projectId,
                                        HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        model.addAttribute("allProjects", projectService.getAllProjects());

        if (projectId != null) {
            Project project = projectService.getProjectById(projectId);
            model.addAttribute("project", project);
        }

        return "updateProject";
    }

    @PostMapping("/update")
    public String updateProject(@ModelAttribute Project project, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        try {
            projectService.updateProject(project);
            model.addAttribute("success", "Project updated successfully!");
            model.addAttribute("project", project); // reattach the updated project to refill the form
            model.addAttribute("allProjects", projectService.getAllProjects()); // in case you show a dropdown
            return "updateProject"; // return to the same page
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update project: " + e.getMessage());
            return "updateProject";
        }
}
}