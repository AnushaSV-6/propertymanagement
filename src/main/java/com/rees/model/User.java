package com.rees.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	

    @Id
    @Column(name = "user_id", nullable = false, unique = true)
    private String userId;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, length = 20)
    private String phone;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;


    public enum Role {
        ADMIN,
        CUSTOMER
    }

    public enum Status {
        ACTIVE,
        INACTIVE,
        PENDING
    }
}
