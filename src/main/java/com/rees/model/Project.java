package com.rees.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "project")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int projectId;

    @Column(nullable = false)
    private String projectName;

    @Column(nullable = false)
    private String surveyNumber;

    @Column(nullable = false)
    private String location;

    @Column(name = "total_area", nullable = false)
    private String totalArea;

    @Column(name = "saleable_area", nullable = false)
    private String saleableArea;

    @Column(name = "map_pdf")
    private String mapPdf;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProjectType projectType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProjectStatus projectStatus;

    @OneToMany(mappedBy = "project")
    private List<Plot> plots; // One project can have many plots

    @OneToMany(mappedBy = "project")
    private List<Sales> sales; // One project can have many sales
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;
    
    @Column(name = "updated_at", columnDefinition = "DATETIME(6)")
    private Timestamp updatedAt;
    
   
    public enum ProjectType {
        JV, OWN
    }

    public enum ProjectStatus {
        COMPLETED, JV, PURCHASED, REGISTERED, STARTED, UNDERAGREEMENT
    }
}
