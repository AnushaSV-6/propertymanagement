package com.rees.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping( "/index")
	public String showIndex() {
	    return "public/index";
	}


    @GetMapping("/login")
    public String showLoginPage() {
        return "public/login";
    
    }
}