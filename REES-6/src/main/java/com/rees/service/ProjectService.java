package com.rees.service;

import com.rees.dao.ProjectDAO;
import com.rees.model.Project;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectService {

    @Autowired
    private ProjectDAO projectDAO;
    

    public void saveProject(Project project) throws Exception {
        projectDAO.saveProject(project);
    }

    public void updateProject(Project project) {
        projectDAO.updateProject(project);
    }

    public Project getProjectById(int projectId) {
        return projectDAO.getProjectById(projectId);
    }

    public List<Project> getAllProjects() {
        return projectDAO.getAllProjects();
    }
}




