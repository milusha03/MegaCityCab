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


public class DeleteAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int adminId = Integer.parseInt(request.getParameter("admin_id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM admins WHERE admin_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, adminId);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("addAdmin.jsp?message=Admin deleted successfully.");
            } else {
                response.sendRedirect("addAdmin.jsp?error=Failed to delete admin.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAdmin.jsp?error=Database error.");
        }
    }
}
