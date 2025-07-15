package com.rees.config;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class SessionAuthFilter implements Filter {


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        
        if (path.startsWith("/rees/admin")) {
            HttpSession session = req.getSession(false);

            boolean isLoggedIn = session != null &&
                    session.getAttribute("email") != null &&
                    session.getAttribute("role") != null &&
                    "ADMIN".equals(session.getAttribute("role").toString());

            if (!isLoggedIn) {
            	res.sendRedirect(req.getContextPath() + "/rees/login"); 
                return;
            }
        }

        
        chain.doFilter(request, response);
    }
} 