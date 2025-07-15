package com.rees.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@Entity
@Table(name = "sales")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Sales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int salesId;

    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

    @ManyToOne
    @JoinColumn(name = "plot_id")
    private Plot plot;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column(nullable = false)
    private double amountReceived;

    @Column(nullable = false)
    private double sellingPrice;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentMode modeOfPayment;

    @Column
    private String description;

    public enum PaymentMode {
        CASH, CHEQUE, DD
    }
}
