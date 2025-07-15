package com.rees.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.rees.model.PlotInquirer;
import com.rees.service.PlotInquirerService;

@RestController
@RequestMapping("/api")
public class PlotInquiryApiController {

    @Autowired
    private PlotInquirerService service;

    @GetMapping("/projects/available")
    public List<Map<String, Object>> getAvailableProjects() {
        return service.getAvailableProjects();
    }

    @GetMapping("/plots/available/{projectId}")
    public List<Map<String, String>> getAvailablePlotSpecs(@PathVariable int projectId) {
        return service.getAvailablePlotSpecs(projectId);
    }

    @PostMapping("/plot-inquiries")
    public String saveInquiry(@RequestBody Map<String, String> data) {
        boolean success = service.saveInquiry(data);
        return success ? "SUCCESS" : "FAILED";
    }
    @GetMapping("/plot-inquiries")
    public List<PlotInquirer> getAllInquiries() {
        return service.getAllInquirers();
    }
}

