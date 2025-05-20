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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/admin/sales")
public class SalesController {

    @Autowired
    private SalesService salesService;
    
    @GetMapping
    public String showManageSales(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        return "manageSales";
    }
    
    @GetMapping("/add")
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
        String phone = request.getParameter("phone");
        int projectId = Integer.parseInt(request.getParameter("projectId"));

        Customer customer = salesService.getCustomerByPhone(phone);
        Project selectedProject = salesService.getProjectById(projectId); // You may need to add this method

        if (customer != null && selectedProject != null) {
            request.setAttribute("customer", customer);
            request.setAttribute("selectedProject", selectedProject);
            request.setAttribute("projects", salesService.getAllProjects());

            List<Plot> plots = salesService.getAvailablePlotsByProject(projectId);
            request.setAttribute("plots", plots);
        } else {
            request.setAttribute("error", "Invalid customer or project.");
        }

        return "addSales";
    }

    @PostMapping("/checkSale")
    public String checkSale(HttpServletRequest request) throws SQLException {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        int plotId = Integer.parseInt(request.getParameter("plotId"));
        String phone = request.getParameter("phone");

        Customer customer = salesService.getCustomerByPhone(phone);
        Project selectedProject = salesService.getProjectById(projectId);
        Plot selectedPlot = salesService.getPlotById(plotId);

        boolean exists = salesService.saleExists(customer.getCustomerId(), projectId, plotId);

        request.setAttribute("customer", customer);
        request.setAttribute("projects", salesService.getAllProjects());
        request.setAttribute("selectedProject", selectedProject);
        request.setAttribute("selectedPlot", selectedPlot);
        request.setAttribute("plots", salesService.getAvailablePlotsByProject(projectId));
        request.setAttribute("saleExists", exists);

        return "addSales";
    }
    @GetMapping("/updateSales")
    public String showUpdateSales(@RequestParam("customerId") int customerId,
                                  @RequestParam("projectId") int projectId,
                                  @RequestParam("plotId") int plotId,
                                  HttpServletRequest request,
                                  HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");

        if (email == null || role != User.Role.ADMIN) {
            return "redirect:/";
        }

        Sales sale = salesService.getSaleByCustomerProjectPlot(customerId, projectId, plotId);
        Customer customer = salesService.getCustomerById(customerId);
        Project project = salesService.getProjectById(projectId);
        Plot plot = salesService.getPlotById(plotId);

        if (sale == null || customer == null || project == null || plot == null) {
            request.setAttribute("error", "Sale record not found.");
            return "addSales";
        }

        request.setAttribute("sale", sale);
        request.setAttribute("customer", customer);
        request.setAttribute("selectedProject", project);
        request.setAttribute("selectedPlot", plot);

        return "updateSales"; // this should be your JSP: updateSales.jsp
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
            request.setAttribute("success", "Sale recorded successfully.");
        } catch (Exception e) {
            request.setAttribute("error", "Error saving sale.");
            e.printStackTrace();
        }
        return "addSales";
    }
    @GetMapping("/update")
    public String showUpdateForm(HttpSession session) {
    	        String email = (String) session.getAttribute("email");
    	        User.Role role = (User.Role) session.getAttribute("role");

    	        if (email == null || role != User.Role.ADMIN) {
    	            return "redirect:/";
    	        }

    	        return "updateSales";
    	    }
     
    @PostMapping("/update")
    public String handleUpdateFlow(HttpServletRequest request, HttpSession session) throws SQLException {
        if (!isAdmin(session)) return "redirect:/";

        String phone = request.getParameter("phone");
        String projectIdStr = request.getParameter("projectId");
        String plotIdStr = request.getParameter("plotId");

        if (phone != null && projectIdStr == null) {
            Customer customer = salesService.getCustomerByPhone(phone);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("projects", salesService.getProjectsWithSales(customer.getCustomerId()));
            } else {
                request.setAttribute("error", "Customer not found.");
            }
            return "updateSales";
        }

        if (phone != null && projectIdStr != null && plotIdStr == null) {
            Customer customer = salesService.getCustomerByPhone(phone);
            int projectId = Integer.parseInt(projectIdStr);
            request.setAttribute("customer", customer);
            request.setAttribute("selectedProjectId", projectId);
            request.setAttribute("projects", salesService.getProjectsWithSales(customer.getCustomerId()));
            request.setAttribute("plots", salesService.getPlotsWithSales(customer.getCustomerId(), projectId));
            return "updateSales";
        }

        if (phone != null && projectIdStr != null && plotIdStr != null) {
            Customer customer = salesService.getCustomerByPhone(phone);
            int projectId = Integer.parseInt(projectIdStr);
            int plotId = Integer.parseInt(plotIdStr);
            Sales sale = salesService.getSale(customer.getCustomerId(), projectId, plotId);

            request.setAttribute("customer", customer);
            request.setAttribute("selectedProjectId", projectId);
            request.setAttribute("selectedPlotId", plotId);
            request.setAttribute("projects", salesService.getProjectsWithSales(customer.getCustomerId()));
            request.setAttribute("plots", salesService.getPlotsWithSales(customer.getCustomerId(), projectId));
            request.setAttribute("sale", sale);
            request.setAttribute("installmentsRemaining", sale.getAmountReceived() < sale.getSellingPrice());

            return "updateSales";
        }

        request.setAttribute("error", "Unexpected input.");
        return "updateSales";
    }
    @PostMapping("/addInstallment")
    public String addInstallment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            int saleId = Integer.parseInt(request.getParameter("saleId"));
            double amount = Double.parseDouble(request.getParameter("amountReceived"));
            String mop = request.getParameter("modeOfPayment");
            String description = request.getParameter("description");
            Date date = Date.valueOf(request.getParameter("paymentDate"));

            salesService.insertSalePayment(saleId, amount, date, mop, description);
            redirectAttributes.addFlashAttribute("success", "Installment added.");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error adding installment.");
        }
        return "redirect:/admin/sales/update";
    }
    private boolean isAdmin(HttpSession session) {
        String email = (String) session.getAttribute("email");
        User.Role role = (User.Role) session.getAttribute("role");
        return email != null && role == User.Role.ADMIN;
    }


}
