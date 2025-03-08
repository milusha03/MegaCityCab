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


public class DeleteDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driver_id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM drivers WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("addDrivers.jsp?message=Driver deleted successfully.");
            } else {
                response.sendRedirect("addDrivers.jsp?error=Failed to delete driver.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addDrivers.jsp?error=Database error.");
        }
    }
}
