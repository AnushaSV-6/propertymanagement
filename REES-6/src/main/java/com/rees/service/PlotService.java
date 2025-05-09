package com.rees.service;

import com.rees.dao.PlotDAO;
import com.rees.model.Plot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlotService {

    @Autowired
    private PlotDAO plotDAO;

    public void addPlot(Plot plot) throws Exception {
        plotDAO.save(plot);
    }

    public List<Plot> getAllPlots() throws Exception {
        return plotDAO.getAll();
    }
    public List<Plot> getPlotsByProjectId(int projectId) throws Exception {
        return plotDAO.getByProjectId(projectId);
    }

    
    public Plot getPlotById(int id) throws Exception {
        return plotDAO.getById(id);
    }

    public void updatePlot(Plot plot) throws Exception {
        plotDAO.update(plot);
    }

    public List<Plot> getPlotsByStatus(String status) throws Exception {
        return plotDAO.getByStatus(status);
    }
}
