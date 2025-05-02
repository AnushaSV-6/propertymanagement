package com.rees.model;

import lombok.*;

import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "customer")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int customerId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String address;

    @Column(name = "contact_number", nullable = false)
    private String contactNumber;

    @Column(name = "aadhaar_number", nullable = false )
    private String aadhaarNumber;

    @Column(name = "pan_number", nullable = false)
    private String panNumber;

    @OneToMany(mappedBy = "customer")
    private List<Plot> plots; 

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;
}
