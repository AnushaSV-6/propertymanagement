package com.rees.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

import com.rees.dto.ProjectDTO;

@Entity
@Table(name = "plot")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Plot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int plotId;

    @ManyToOne
    @JoinColumn(name = "project_id", nullable = false)
    private Project project; 

    @Column(nullable = false)
    private String siteNumber;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PlotStatus status;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column(nullable = false)
    private String size;

    @Column(nullable = false)
    private String facing;

    @Column(nullable = false)
    private String type; 

    @Column(name = "road_width", nullable = false)
    private String roadWidth;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;
    
    @Column(name = "updated_at")
    private Timestamp updatedAt;

    public enum PlotStatus {
        SOLD, BOOKED, AVAILABLE
    }
}
