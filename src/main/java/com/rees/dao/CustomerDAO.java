package com.rees.dao;

import com.rees.model.Customer;
import com.rees.util.QueryLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CustomerDAO {

    @Autowired
    private DataSource dataSource;

    public boolean isPhoneExists(String contactNumber) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("customer.selectByPhone"))) {
            ps.setString(1, contactNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveCustomer(Customer customer) {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("customer.insert"))) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getContactNumber());
            ps.setString(4, customer.getAadhaarNumber());
            ps.setString(5, customer.getPanNumber());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(QueryLoader.getQuery("customer.selectAll"));
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                c.setContactNumber(rs.getString("contact_number"));
                c.setAadhaarNumber(rs.getString("aadhaar_number"));
                c.setPanNumber(rs.getString("pan_number"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                customers.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
}
