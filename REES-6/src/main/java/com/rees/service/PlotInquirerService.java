package com.rees.service;

import com.rees.dao.PlotInquirerDAO;
import com.rees.model.PlotInquirer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class PlotInquirerService {

    @Autowired
    private PlotInquirerDAO inquirerDAO;

    public void addInquirer(String name, String phone, String address) throws Exception {
        PlotInquirer pi = new PlotInquirer();
        pi.setName(name);
        pi.setPhoneNumber(phone);
        pi.setAddress(address);
        pi.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        try {
            inquirerDAO.save(pi);
        } catch (Exception e) {
            throw new Exception("Database error while saving inquirer", e);
        }
    }


    
}
