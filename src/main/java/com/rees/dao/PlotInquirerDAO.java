package com.rees.dao;

import com.rees.model.PlotInquirer;
import com.rees.util.QueryLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

   
}