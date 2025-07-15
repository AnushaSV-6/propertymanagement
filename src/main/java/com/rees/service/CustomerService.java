package com.rees.service;

import com.rees.dao.CustomerDAO;
import com.rees.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    @Autowired
    private CustomerDAO customerDAO;

    public boolean isPhoneExists(String contact) {
        return customerDAO.isPhoneExists(contact);
    }
    
    

    public boolean saveCustomer(Customer customer) {
        return customerDAO.saveCustomer(customer);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }
}
