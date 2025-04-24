package com.rees.service;

import com.rees.dao.ProjectDAO;
import com.rees.model.Project;
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

    public List<Project> getAllProjects() throws Exception {
        return projectDAO.getAllProjects();
    }



}
