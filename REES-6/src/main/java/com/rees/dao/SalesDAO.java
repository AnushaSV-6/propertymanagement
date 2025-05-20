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

    // Step 1: Lookup Customer by phone
    public Customer findCustomerByPhone(String phone) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("customer.selectByPhone"))) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setContactNumber(rs.getString("contact_number"));
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Step 2: Get all projects
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

    // Step 3: Get plots by project
    public List<Plot> getPlotsByProject(int projectId) {
        List<Plot> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.selectByProject"))) {

            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                plot.setSiteNumber(rs.getString("site_number"));
                plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").toUpperCase()));
                list.add(plot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Step 4: Check if sale exists (Customer + Project + Plot)
    public boolean saleExists(int customerId, int projectId, int plotId) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.existsByCustomerProjectPlot"))) {

            ps.setInt(1, customerId);
            ps.setInt(2, projectId);
            ps.setInt(3, plotId);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    // Step 5: Get existing sale (Customer + Project + Plot)
    public Sales getSale(int customerId, int projectId, int plotId) throws SQLException {
        String query = QueryLoader.getQuery("sales.findByCustomerProjectPlot");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);
            ps.setInt(2, projectId);
            ps.setInt(3, plotId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Sales sale = new Sales();
                sale.setSalesId(rs.getInt("sales_id"));
                sale.setAmountReceived(rs.getDouble("amount_received"));
                sale.setSellingPrice(rs.getDouble("selling_price"));
                sale.setModeOfPayment(Sales.PaymentMode.valueOf(rs.getString("mode_of_payment")));
                sale.setDescription(rs.getString("description"));

                // Minimal linked model
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                sale.setPlot(plot);

                return sale;
            }
        }
        return null;
    }
    public List<Plot> getAvailablePlots(int projectId) {
        List<Plot> list = new ArrayList<>();
        String query = QueryLoader.getQuery("get.available.plots.by.project"); // this must have a `?`

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, projectId); // must match one `?` in query
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                plot.setSiteNumber(rs.getString("site_number"));
                plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").toUpperCase()));
                list.add(plot);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Project getProjectById(int projectId) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("project.selectById"))) {

            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                return project;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Plot getPlotById(int plotId) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.selectById"))) {

            ps.setInt(1, plotId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                plot.setSiteNumber(rs.getString("site_number"));
                plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").toUpperCase()));
                return plot;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
 // Find a Sale by Customer, Project, and Plot
    public Sales findByCustomerProjectPlot(int customerId, int projectId, int plotId) {
        Sales sale = null;
        String query = QueryLoader.getQuery("sales.findByCustomerProjectPlot");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);
            ps.setInt(2, projectId);
            ps.setInt(3, plotId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sale = new Sales();
                    sale.setSalesId(rs.getInt("sales_id"));
                    sale.setAmountReceived(rs.getDouble("amount_received"));
                    sale.setSellingPrice(rs.getDouble("selling_price"));
                    sale.setModeOfPayment(Sales.PaymentMode.valueOf(rs.getString("mode_of_payment")));
                    sale.setDescription(rs.getString("description"));

                    Plot plot = new Plot();
                    plot.setPlotId(rs.getInt("plot_id"));
                    sale.setPlot(plot);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sale;
    }

    // Find Customer by ID
    public Customer findCustomerById(int customerId) {
        Customer customer = null;
        String query = QueryLoader.getQuery("customer.selectById");
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setName(rs.getString("name"));
                    customer.setContactNumber(rs.getString("contact_number"));
                    // add other customer fields here as needed
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    public List<Project> getProjectsWithSales(int customerId) {
        List<Project> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.getprojectwithsales"))) {

            ps.setInt(1, customerId);
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
    public List<Plot> getPlotsWithSales(int customerId, int projectId) {
        List<Plot> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.getplotwithsales"))){

            ps.setInt(1, customerId);
            ps.setInt(2, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                plot.setSiteNumber(rs.getString("site_number"));
                plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").toUpperCase()));
                list.add(plot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Step 6: Get Sale by ID (used for updating plot status)
    public Sales getSaleById(int saleId) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.getsalesid"))) {

            ps.setInt(1, saleId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Sales sale = new Sales();
                sale.setSalesId(rs.getInt("sales_id"));
                sale.setAmountReceived(rs.getDouble("amount_received"));
                sale.setSellingPrice(rs.getDouble("selling_price"));

                Plot plot = new Plot();
                plot.setPlotId(rs.getInt("plot_id"));
                sale.setPlot(plot);

                return sale;
            }
        }
        return null;
    }

    // Step 7: Add new Sale (initial)
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

    // Step 8: Mark plot as booked with customer
    public void updatePlotStatus(int plotId, int customerId) throws Exception {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.updateStatusAndCustomer"))) {

            ps.setInt(1, customerId);
            ps.setInt(2, plotId);
            ps.executeUpdate();
        }
    }

    // Step 9: Add Installment (payment)
    public void insertSalePayment(int saleId, double amount, Date date, String mop, String description) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {

            // 1. Insert payment
            try (PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sale_payment.insert"))) {
                ps.setInt(1, saleId);
                ps.setDouble(2, amount);
                ps.setDate(3, new java.sql.Date(date.getTime()));
                ps.setString(4, mop);
                ps.setString(5, description);
                ps.executeUpdate();
            }

            // 2. Update sale's amount_received
            try (PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("sales.updateAmountReceived"))) {
                ps.setDouble(1, amount);
                ps.setInt(2, saleId);
                ps.executeUpdate();
            }

            // 3. If fully paid, mark plot as SOLD
            Sales sale = getSaleById(saleId);
            if ((sale.getAmountReceived() + amount) >= sale.getSellingPrice()) {
                try (PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("plot.markSold"))) {
                    ps.setInt(1, sale.getPlot().getPlotId());
                    ps.executeUpdate();
                }
            }
        }
    }
}
