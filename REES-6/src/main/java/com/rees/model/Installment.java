package com.rees.model;

import jakarta.persistence.*;
import lombok.*;
import java.sql.Date;

@Entity
@Table(name = "installments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Installment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "sale_id")
    private Sales sale;

    private double amountPaid;
    private Date datePaid;

    @Enumerated(EnumType.STRING)
    private Sales.PaymentMode mop;

    private String description;
}
