package com.rees.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Project.ProjectStatus;
import com.rees.model.Project.ProjectType;
import com.rees.util.QueryLoader;

@Repository
public class PlotDAO {
	 
	@Autowired
	    private DataSource dataSource;
	 
	public List<Plot> getAllPlots() {
	    List<Plot> plots = new ArrayList<>();
	    String sql = QueryLoader.getQuery("plot.selectAll");

	    try (Connection con = dataSource.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Plot plot = new Plot();
	            plot.setPlotId(rs.getInt("plot_id"));
	            plot.setSiteNumber(rs.getString("site_number"));
	            plot.setStatus(Plot.PlotStatus.valueOf(rs.getString("status").trim().toUpperCase()));
	            plot.setSize(rs.getString("size"));
	            plot.setFacing(rs.getString("facing"));
	            plot.setType(rs.getString("type"));
	            plot.setRoadWidth(rs.getString("road_width"));
	            plot.setCreatedAt(rs.getTimestamp("created_at"));

	            // Fetching and setting project inside plot
	            Project project = new Project();
	            project.setProjectId(rs.getInt("project_id"));
	            project.setProjectName(rs.getString("project_name"));
	            plot.setProject(project);  

	            plots.add(plot); // Correct
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return plots;
	}
}