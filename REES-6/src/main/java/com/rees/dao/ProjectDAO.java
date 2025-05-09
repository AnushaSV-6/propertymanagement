package com.rees.dao;

import com.rees.model.Project;
import com.rees.model.Project.ProjectStatus;
import com.rees.model.Project.ProjectType;
import com.rees.util.QueryLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProjectDAO {

    @Autowired
    private DataSource dataSource;

    // Method to save a new project
    public void saveProject(Project project) {
        String sql = QueryLoader.getQuery("project.insert");  // Get the insert query from the properties file

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Setting parameters to the prepared statement
            ps.setString(1, project.getProjectName());
            ps.setString(2, project.getSurveyNumber());
            ps.setString(3, project.getLocation());
            ps.setString(4, project.getTotalArea());
            ps.setString(5, project.getSaleableArea());
            ps.setString(6, project.getProjectType().name());
            ps.setString(7, project.getProjectStatus().name());
            ps.setString(8, project.getMapPdf());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));


            ps.executeUpdate();  // Execute the insert query

        } catch (SQLException e) {
            e.printStackTrace();  // Logging should be done instead of print in production code
        }
    }

    // Method to get all projects
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = QueryLoader.getQuery("project.selectAll");  // Get the select query from the properties file

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            // Looping through the result set and populating the list
            while (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                project.setSurveyNumber(rs.getString("survey_number"));
                project.setLocation(rs.getString("location"));
                project.setTotalArea(rs.getString("total_area"));
                project.setSaleableArea(rs.getString("saleable_area"));
                project.setProjectType(ProjectType.valueOf(rs.getString("project_type").trim().toUpperCase()));
                project.setProjectStatus(ProjectStatus.valueOf(rs.getString("project_status").trim().toUpperCase()));
                project.setMapPdf(rs.getString("map_pdf"));
                projects.add(project);  // Add the project to the list
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Logging should be done instead of print in production code
        }

        return projects;
    }

    // Method to get a project by its ID
    public Project getProjectById(int projectId) {
        Project project = null;
        String sql = QueryLoader.getQuery("project.selectById");  // Get the select query from the properties file

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, projectId);  // Set project ID as a parameter to the query

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    project = new Project();
                    project.setProjectId(rs.getInt("project_id"));
                    project.setProjectName(rs.getString("project_name"));
                    project.setSurveyNumber(rs.getString("survey_number"));
                    project.setLocation(rs.getString("location"));
                    project.setTotalArea(rs.getString("total_area"));
                    project.setSaleableArea(rs.getString("saleable_area"));
                    project.setProjectType(ProjectType.valueOf(rs.getString("project_type").trim().toUpperCase()));
                    project.setProjectStatus(ProjectStatus.valueOf(rs.getString("project_status").trim().toUpperCase()));
                    project.setMapPdf(rs.getString("map_pdf"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Logging should be done instead of print in production code
        }

        return project;
    }

    public void updateProject(Project project) {
        String sql = QueryLoader.getQuery("project.update");

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, project.getProjectName());
            ps.setString(2, project.getSurveyNumber());
            ps.setString(3, project.getLocation());
            ps.setString(4, project.getTotalArea());
            ps.setString(5, project.getSaleableArea());
            ps.setString(6, project.getProjectType().name());
            ps.setString(7, project.getProjectStatus().name());
            ps.setString(8, project.getMapPdf());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));

            ps.setInt(10, project.getProjectId());

            int rows = ps.executeUpdate();
            System.out.println("Rows affected: " + rows);
            if (rows == 0) {
                System.err.println("No project updated. Possibly invalid project ID: " + project.getProjectId());
            }

        } catch (SQLException e) {
            System.err.println("Failed to update project: " + e.getMessage());
            e.printStackTrace();
        }
    }
}