package com.megacitycab.dao;

import com.megacitycab.model.Customer;
import com.megacitycab.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class CustomerDAO {
    
    // Fetch customer data by ID
    public Customer getCustomerById(int customerId) {
        Customer customer = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE customer_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                customer = new Customer(
                    rs.getInt("customer_id"),
                    rs.getString("full_name"),
                    rs.getString("nic"),
                    rs.getString("email"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    rs.getString("username"),
                    rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    // Update customer data
    public boolean updateCustomer(int customerId, String fullName, String nic, String email, String phoneNumber, String address, String username, String newPassword) {
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = DBConnection.getConnection();
        
        // Update query: Set password only if newPassword is not null
        String sql = "UPDATE customers SET full_name=?, nic=?, email=?, phone_number=?, address=?, username=?"
                   + (newPassword != null ? ", password=?" : "")
                   + " WHERE customer_id=?";
        
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, fullName);
        stmt.setString(2, nic);
        stmt.setString(3, email);
        stmt.setString(4, phoneNumber);
        stmt.setString(5, address);
        stmt.setString(6, username);

        int index = 7;
        if (newPassword != null) {
            stmt.setString(index++, newPassword); // Hash already applied in servlet
        }
        stmt.setInt(index, customerId);

        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

}
