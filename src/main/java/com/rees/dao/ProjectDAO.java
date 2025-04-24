package com.rees.dao;

import com.rees.model.Project;
import com.rees.model.Project.ProjectStatus;
import com.rees.model.Project.ProjectType;
import com.rees.util.QueryLoader;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void saveProject(Project project) throws Exception {
        String sql = QueryLoader.getQuery("insertProject");

        // Insert the project into the database
        jdbcTemplate.update(sql,
        	    project.getProjectName(),
        	    project.getSurveyNumber(),
        	    project.getLocation(),
        	    project.getTotalArea(),
        	    project.getSaleableArea(),
        	    project.getProjectType().name(),     // 👈 Converts enum to string like "JV"
        	    project.getProjectStatus().name(),   // 👈 Converts enum to string like "STARTED"
        	    project.getMapPdf()
        	);

}
    public List<Project> getAllProjects() throws Exception {
        String sql = QueryLoader.getQuery("getAllProjects");  
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Project project = new Project();
            project.setProjectId(rs.getInt("project_id"));
            project.setProjectName(rs.getString("project_name"));
            project.setSurveyNumber(rs.getString("survey_number"));
            project.setLocation(rs.getString("location"));
            project.setTotalArea(rs.getDouble("total_area"));
            project.setSaleableArea(rs.getDouble("saleable_area"));
            project.setProjectType(ProjectType.valueOf(rs.getString("project_type").trim().toUpperCase()));
            project.setProjectStatus(ProjectStatus.valueOf(rs.getString("project_status").trim().toUpperCase()));
            project.setMapPdf(rs.getString("map_pdf"));
            return project;
        });
    }

}