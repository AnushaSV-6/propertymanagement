package com.rees.controller;

import com.rees.model.Customer;
import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Sales;
import com.rees.model.User;
import com.rees.service.SalesService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/sales")
public class SalesController {

    @Autowired
    private SalesService salesService;
    
    @GetMapping
    public String showAddSales(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "addSales";
    }
    
    @PostMapping("/checkCustomer")
    public String checkCustomer(HttpServletRequest request) {
        String phone = request.getParameter("phone");
        Customer customer = salesService.getCustomerByPhone(phone);

        if (customer != null) {
            request.setAttribute("customer", customer);
            List<Project> projects = salesService.getAllProjects();
            request.setAttribute("projects", projects);
        } else {
            request.setAttribute("error", "Customer not found.");
        }
        return "addSales";
    }

    @PostMapping("/getPlots")
    public String getAvailablePlots(HttpServletRequest request) {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        List<Plot> plots = salesService.getAvailablePlotsByProject(projectId);
        request.setAttribute("plots", plots);
        request.setAttribute("projectId", projectId);
        request.setAttribute("customerId", request.getParameter("customerId"));
        
        return "addSales";
    }

    @PostMapping("/submit")
    public String submitSale(HttpServletRequest request) {
        try {
            Sales sale = new Sales();
            sale.setAmountReceived(Double.parseDouble(request.getParameter("amountReceived")));
            sale.setSellingPrice(Double.parseDouble(request.getParameter("sellingPrice")));
            sale.setModeOfPayment(Sales.PaymentMode.valueOf(request.getParameter("modeOfPayment")));
            sale.setDescription(request.getParameter("description"));

            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            int plotId = Integer.parseInt(request.getParameter("plotId"));

            salesService.saveSale(sale, customerId, projectId, plotId);
            request.setAttribute("message", "Sale recorded successfully.");
        } catch (Exception e) {
            request.setAttribute("error", "Error saving sale.");
            e.printStackTrace();
        }
        return "addSales";
    }
}
