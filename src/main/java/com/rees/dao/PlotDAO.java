package com.rees.dao;

import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Customer;
import com.rees.util.QueryLoader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class PlotDAO {

    @Autowired
    private DataSource dataSource;

    private final RowMapper<Plot> rowMapper = (rs, rowNum) -> {
        Plot plot = new Plot();

        Project project = new Project();
        project.setProjectId(rs.getInt("project_id"));
        project.setProjectName(rs.getString("project_name")); // Added
        plot.setProject(project);

        plot.setPlotId(rs.getInt("plot_id"));
        plot.setSiteNumber(rs.getString("site_number"));
        plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").toUpperCase()));
        plot.setSize(rs.getString("size"));
        plot.setFacing(rs.getString("facing"));
        plot.setType(rs.getString("type"));
        plot.setRoadWidth(rs.getString("road_width"));
        plot.setCreatedAt(rs.getTimestamp("created_at"));
        plot.setUpdatedAt(rs.getTimestamp("updated_at"));

        int customerId = rs.getInt("customer_id");
        if (customerId != 0) {
            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setName(rs.getString("customer_name")); 
            plot.setCustomer(customer);
        }

        return plot;
    };


    public void save(Plot plot) throws Exception {
        String sql = QueryLoader.getQuery("plot.insert");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, plot.getProject().getProjectId());
            ps.setString(2, plot.getSiteNumber());
            ps.setString(3, plot.getSize());
            ps.setString(4, plot.getFacing());
            ps.setString(5, plot.getType());
            ps.setString(6, plot.getRoadWidth());

            ps.executeUpdate();
        }
    }

    public List<Plot> getAll() throws Exception {
        String sql = QueryLoader.getQuery("plot.selectAll");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Plot> list = new ArrayList<>();
            while (rs.next()) {
                list.add(rowMapper.mapRow(rs, rs.getRow()));
            }
            return list;
        }
    }
    public List<Plot> getByProjectId(int projectId) throws Exception {
        String sql = QueryLoader.getQuery("plot.selectByProject");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Plot> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(rowMapper.mapRow(rs, rs.getRow()));
                }
                return list;
            }
        }
    }

    public Plot getById(int id) throws Exception {
        String sql = QueryLoader.getQuery("plot.selectById");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rowMapper.mapRow(rs, 1);
                }
            }
        }
        return null;
    }

    public void update(Plot plot) throws Exception {
        String sql = QueryLoader.getQuery("plot.update");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, plot.getSiteNumber());
            ps.setString(2, plot.getStatus().toString().toLowerCase());
            ps.setString(3, plot.getSize());
            ps.setString(4, plot.getFacing());
            ps.setString(5, plot.getType());
            ps.setString(6, plot.getRoadWidth());
            ps.setInt(7, plot.getPlotId());

            ps.executeUpdate();
        }
    }

    public List<Plot> getByStatus(String status) throws Exception {
        String sql = QueryLoader.getQuery("plot.selectByStatus");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                List<Plot> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(rowMapper.mapRow(rs, rs.getRow()));
                }
                return list;
            }
        }
    }
}
