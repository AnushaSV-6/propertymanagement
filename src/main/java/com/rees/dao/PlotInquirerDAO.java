package com.rees.dao;

import com.rees.model.PlotInquirer;
import com.rees.model.Project;
import com.rees.util.QueryLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PlotInquirerDAO {

    @Autowired
    private DataSource dataSource;

    public void save(PlotInquirer inquirer) {
        String sql = QueryLoader.getQuery("plotinquirer.insert");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inquirer.getPhoneNumber());
            ps.setString(2, inquirer.getName());
            ps.setString(3, inquirer.getAddress());
            ps.setTimestamp(4, inquirer.getCreatedAt());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, String>> getAvailablePlotSpecs(int projectId) {
        List<Map<String, String>> plotSpecs = new ArrayList<>();

        String query = "SELECT DISTINCT size AS size, facing AS facing FROM plot WHERE project_id = ? AND status = 'available'";

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, projectId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String size = rs.getString("size");
                    String facing = rs.getString("facing");
                    

                    Map<String, String> row = new HashMap<>();
                    row.put("size", size);
                    row.put("facing", facing);
                    plotSpecs.add(row);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return plotSpecs;
    }

    public List<Map<String, Object>> getAvailableProjects() {
        List<Map<String, Object>> projectList = new ArrayList<>();
        String query = QueryLoader.getQuery("sales.getAvailableProjects");

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("project_id", rs.getInt("project_id"));
                row.put("project_name", rs.getString("project_name"));
                projectList.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return projectList;
    }

    public boolean insertInquiry(Map<String, String> data) {
        String query = "INSERT INTO plot_inquirer " +
                       "(phone_number, name, address, project_id, plot_size, plot_facing, description, created_at) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, data.get("phoneNumber"));
            ps.setString(2, data.get("name"));
            ps.setString(3, data.get("address"));
            ps.setInt(4, Integer.parseInt(data.get("projectId")));
            ps.setString(5, data.get("plotSize"));
            ps.setString(6, data.get("plotFacing"));
            ps.setString(7, data.get("description"));

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<PlotInquirer> getAllInquirers() {
        List<PlotInquirer> list = new ArrayList<>();

        String sql = "SELECT pi.*, p.project_id, p.project_name " +
                "FROM plot_inquirer pi " +
                "JOIN project p ON pi.project_id = p.project_id " +
                "ORDER BY pi.created_at DESC";


        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PlotInquirer p = new PlotInquirer();
                p.setInquiryId(rs.getInt("inquiry_id"));
                p.setName(rs.getString("name"));
                p.setPhoneNumber(rs.getString("phone_number"));
                p.setAddress(rs.getString("address"));
                p.setPlotSize(rs.getString("plot_size"));
                p.setPlotFacing(rs.getString("plot_facing"));
                p.setDescription(rs.getString("description"));
                p.setCreatedAt(rs.getTimestamp("created_at"));

                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                p.setProject(project);

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



}