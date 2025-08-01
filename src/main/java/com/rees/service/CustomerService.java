package com.rees.service;

import com.rees.dto.CustomerDTO;
import com.rees.mapper.CustomerMapper;
import com.rees.model.Customer;
import com.rees.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import java.sql.Timestamp;
import java.util.List;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerMapper customerMapper;

    public boolean isPhoneExists(String contactNumber) {
        return customerRepository.existsByContactNumber(contactNumber);
    }

    public boolean saveCustomer(CustomerDTO dto) {
        try {
            Customer customer = customerMapper.toEntity(dto);
            customer.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            customerRepository.save(customer);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CustomerDTO> getAllCustomers() {
        return customerMapper.toDtoList(customerRepository.findAll());
    }
}
