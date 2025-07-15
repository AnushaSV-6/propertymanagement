package com.rees.controller;


import com.rees.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("/rees/adminDashboard")
	public String showAdminDashboard(HttpSession session) {
		String email = (String) session.getAttribute("email");
		String roleStr = (String) session.getAttribute("role");

		if (email == null || roleStr == null || User.Role.valueOf(roleStr) != User.Role.ADMIN) {
			return "redirect:/public/login.jsp";
		}

		return "secure/adminDashboard";
	}


	@GetMapping("/rees/admin/logout")
	public String showLogoutPage(HttpSession session) {
	    if (session != null) {
	        session.invalidate(); 
	    }
	    return "redirect:/rees/login";
	}

}
