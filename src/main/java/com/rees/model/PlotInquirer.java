package com.rees.model;


import java.sql.Timestamp;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "plot_inquirer")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PlotInquirer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int inquiryId;

    @Column(name = "phone_number", nullable = false, length = 10)
    private String phoneNumber;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String address;
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

    @Column(name = "plot_size")
    private String plotSize;

    @Column(name = "plot_facing")
    private String plotFacing;

    @Column(length = 1000)
    private String description;

}

