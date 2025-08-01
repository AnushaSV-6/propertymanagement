package com.rees.controller;

import com.rees.dto.ProjectDTO;
import com.rees.model.User;
import com.rees.service.ProjectService;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/rees/admin/projects")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @GetMapping("/rees/admin/projects")
    public String backButtom(HttpSession session) {
        return "secure/manageProject";
    }

    @GetMapping
    public String showManageProjectPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/public/login.jsp";
        return "secure/manageProject";
    }

    @GetMapping("/addproject")
    public String showAddProjectPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/public/login.jsp";
        return "secure/addProject";
    }

    @PostMapping("/save")
    public String saveProject(@ModelAttribute ProjectDTO projectDTO, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/public/login.jsp";
        try {
            projectService.saveProject(projectDTO);
            model.addAttribute("message", "Project added successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error adding project: " + e.getMessage());
        }
        return "secure/addProject";
    }

    @GetMapping("/viewProjects")
    public String viewProjects(Model model) {
        try {
            List<ProjectDTO> projects = projectService.getAllProjects();
            model.addAttribute("projects", projects);
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load projects");
            e.printStackTrace();
        }
        return "secure/viewProjects";
    }

    @GetMapping("/updateproject")
    public String showUpdateProjectForm(@RequestParam(value = "projectId", required = false) Integer projectId,
                                        HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/public/login.jsp";
        model.addAttribute("allProjects", projectService.getAllProjects());
        if (projectId != null) {
            ProjectDTO project = projectService.getProjectById(projectId);
            model.addAttribute("project", project);
        }
        return "secure/updateProject";
    }

    @PostMapping("/update")
    public String updateProject(@ModelAttribute ProjectDTO projectDTO, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/public/login.jsp";
        try {
            projectService.updateProject(projectDTO);
            model.addAttribute("success", "Project updated successfully!");
            model.addAttribute("project", projectDTO);
            model.addAttribute("allProjects", projectService.getAllProjects());
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update project: " + e.getMessage());
        }
        return "secure/updateProject";
    }

    private boolean isAdmin(HttpSession session) {
        String email = (String) session.getAttribute("email");
        String roleStr = (String) session.getAttribute("role");
        return email != null && roleStr != null && User.Role.valueOf(roleStr) == User.Role.ADMIN;
    }
}
