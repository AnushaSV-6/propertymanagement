package com.rees.dao;

import com.rees.model.*;
import com.rees.util.QueryLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SalesDAO {

    @Autowired
    private DataSource dataSource;

    public Customer findCustomerByPhone(String phone) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("customer.selectByPhone"))) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Project> getAllProjects() {
        List<Project> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("project.selectAll"))) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                list.add(project);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Plot> getAvailablePlots(int projectId) {
        List<Plot> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.selectByProject"))) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                plot.setSiteNumber(rs.getString("site_number"));
                list.add(plot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertSale(Sales sale, int customerId, int projectId, int plotId) throws Exception {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.insert"))) {
            ps.setInt(1, projectId);
            ps.setInt(2, plotId);
            ps.setInt(3, customerId);
            ps.setDouble(4, sale.getAmountReceived());
            ps.setDouble(5, sale.getSellingPrice());
            ps.setString(6, sale.getModeOfPayment().name());
            ps.setString(7, sale.getDescription());
            ps.executeUpdate();
        }
    }

    public void updatePlotStatus(int plotId, int customerId) throws Exception {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.updateStatusAndCustomer"))) {
            ps.setInt(1, customerId);
            ps.setInt(2, plotId);
            ps.executeUpdate();
        }
    }
}
