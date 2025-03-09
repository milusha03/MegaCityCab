package com.megacitycab.servlets;

import com.megacitycab.dao.CustomerDAO;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

            // Hash password if it is provided
            String hashedPassword = null;
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                hashedPassword = hashPassword(newPassword);
            }

            // Call DAO to update customer data
            CustomerDAO customerDAO = new CustomerDAO();
            boolean updated = customerDAO.updateCustomer(customerId, fullName, nic, email, phoneNumber, address, username, hashedPassword);

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

    // Method to hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Convert bytes to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
