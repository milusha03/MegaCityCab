package com.megacitycab.servlets;

import com.megacitycab.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ManageAdminsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("admin_id");

        if (adminId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newAdminUsername = request.getParameter("new_admin_username");
        String newAdminPassword = request.getParameter("new_admin_password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO admins (username, password) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newAdminUsername);
            stmt.setString(2, newAdminPassword);

            int added = stmt.executeUpdate();
            if (added > 0) {
                response.sendRedirect("manageAdmins.jsp?message=New admin added successfully.");
            } else {
                response.sendRedirect("manageAdmins.jsp?error=Failed to add admin.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageAdmins.jsp?error=Database error.");
        }
    }
}
