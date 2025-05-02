package com.rees.service;

import com.rees.dao.SalesDAO;
import com.rees.model.Customer;
import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Sales;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesService {

    @Autowired
    private SalesDAO salesDAO;

    public Customer getCustomerByPhone(String phone) {
        return salesDAO.findCustomerByPhone(phone);
    }

    public List<Project> getAllProjects() {
        return salesDAO.getAllProjects();
    }

    public List<Plot> getAvailablePlotsByProject(int projectId) {
        return salesDAO.getAvailablePlots(projectId);
    }

    public void saveSale(Sales sale, int customerId, int projectId, int plotId) throws Exception {
        salesDAO.insertSale(sale, customerId, projectId, plotId);
        salesDAO.updatePlotStatus(plotId, customerId);
    }
}
