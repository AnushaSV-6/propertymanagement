package com.rees.service;

import com.rees.dto.PlotDTO;
import com.rees.mapper.PlotMapper;
import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Customer;
import com.rees.repository.PlotRepository;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PlotService {

    @Autowired
    private PlotRepository plotRepository;

    @Autowired
    private PlotMapper plotMapper;

    @Autowired
    private EntityManager entityManager; // to get references for associations

    public void addPlot(PlotDTO dto) throws Exception {
        Plot plot = plotMapper.toEntity(dto);

        if (dto.getProjectId() != null) {
            Project projRef = entityManager.getReference(Project.class, dto.getProjectId());
            plot.setProject(projRef);
        }

        if (dto.getCustomerId() != null) {
            Customer custRef = entityManager.getReference(Customer.class, dto.getCustomerId());
            plot.setCustomer(custRef);
        }

        plot.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        String statusStr = dto.getStatus() != null ? dto.getStatus() : "AVAILABLE";
        plot.setStatus(Plot.PlotStatus.valueOf(statusStr.toUpperCase()));

        plotRepository.save(plot);
    }



    public List<PlotDTO> getAllPlots() throws Exception {
        return plotRepository.findAll()
                .stream()
                .map(plotMapper::toDto)
                .collect(Collectors.toList());
    }

    public List<PlotDTO> getPlotsByProjectId(int projectId) throws Exception {
        return plotRepository.findByProject_ProjectId(projectId)
                .stream()
                .map(plotMapper::toDto)
                .collect(Collectors.toList());
    }

    public PlotDTO getPlotById(int id) throws Exception {
        return plotRepository.findById(id)
                .map(plotMapper::toDto)
                .orElse(null);
    }

    public void updatePlot(PlotDTO dto) throws Exception {
        Plot existing = plotRepository.findById(dto.getPlotId())
                .orElseThrow(() -> new Exception("Plot not found"));

        existing.setSiteNumber(dto.getSiteNumber());
        existing.setStatus(Plot.PlotStatus.valueOf(dto.getStatus().toUpperCase()));
        existing.setSize(dto.getSize());
        existing.setFacing(dto.getFacing());
        existing.setType(dto.getType());
        existing.setRoadWidth(dto.getRoadWidth());
        existing.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        if (dto.getProjectId() != null) {
            Project projRef = entityManager.getReference(Project.class, dto.getProjectId());
            existing.setProject(projRef);
        }
        if (dto.getCustomerId() != null) {
            Customer custRef = entityManager.getReference(Customer.class, dto.getCustomerId());
            existing.setCustomer(custRef);
        }

        plotRepository.save(existing);
    }

    public List<PlotDTO> getPlotsByStatus(String status) throws Exception {
        return plotRepository.findByStatus(status.toUpperCase())
                .stream()
                .map(plotMapper::toDto)
                .collect(Collectors.toList());
    }
}
