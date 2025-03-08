package com.megacitycab.servlets;

import com.megacitycab.dao.CustomerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String customerIdStr = request.getParameter("customer_id");
            String fullName = request.getParameter("full_name");
            String nic = request.getParameter("nic");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phone_number");
            String address = request.getParameter("address");
            String username = request.getParameter("username");
            String newPassword = request.getParameter("password");

            if (customerIdStr == null || fullName == null || nic == null || email == null || phoneNumber == null || address == null || username == null) {
                response.sendRedirect("updateProfile.jsp?error=Missing required fields.");
                return;
            }

            int customerId = Integer.parseInt(customerIdStr);

            // Call DAO to update customer data
            CustomerDAO customerDAO = new CustomerDAO();
            boolean updated = customerDAO.updateCustomer(customerId, fullName, nic, email, phoneNumber, address, username, newPassword);

            if (updated) {
                response.sendRedirect("updateProfile.jsp?message=Profile updated successfully.");
            } else {
                response.sendRedirect("updateProfile.jsp?error=Failed to update profile.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateProfile.jsp?error=Server error.");
        }
    }
}
