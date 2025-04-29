package com.rees.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rees.dao.PlotDAO;
import com.rees.model.Plot;
import com.rees.model.Project;

@Service
public class PlotService {

    @Autowired
    private PlotDAO plotDAO;

    public List<Plot> getAllPlots() {
        return plotDAO.getAllPlots();
    }
}
