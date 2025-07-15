package com.rees.controller;

import com.rees.model.Customer;
import com.rees.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("rees/admin/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping
    public String manageCustomerPage() {
        return "secure/manageCustomer"; // Just buttons
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "secure/addCustomer";
    }

    @PostMapping("/save")
    public String saveCustomer(@ModelAttribute Customer customer,
                               RedirectAttributes redirectAttributes) {
        if (customerService.isPhoneExists(customer.getContactNumber())) {
            redirectAttributes.addFlashAttribute("message", "❌ Phone number already exists!");
            return "redirect:/rees/admin/customers/add";
        }

        boolean saved = customerService.saveCustomer(customer);
        if (saved) {
            redirectAttributes.addFlashAttribute("message", "✅ Customer added successfully.");
            return "redirect:/rees/admin/customers/add";
        
        } else {
            redirectAttributes.addFlashAttribute("message", "❌ Error while saving customer.");
            return "redirect:/rees/admin/customers/add";
        }
    }

    @GetMapping("/list")
    public String listCustomers(Model model) {
        List<Customer> customers = customerService.getAllCustomers();
        model.addAttribute("customers", customers);
        return "secure/listCustomers";
    }
}
