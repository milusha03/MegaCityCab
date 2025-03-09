package com.megacitycab.servlets;

import com.megacitycab.dao.DriverDAO;
import com.megacitycab.model.Driver;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditDriverServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String driverIdStr = request.getParameter("driverId");

        if (driverIdStr == null || driverIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Driver ID is missing.");
            return;
        }

        int driverId = Integer.parseInt(driverIdStr);
        DriverDAO driverDAO = new DriverDAO();
        Driver driver = driverDAO.getDriverById(driverId);

        if (driver == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Driver not found.");
            return;
        }

        request.setAttribute("driver", driver);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editDriver.jsp");
        dispatcher.forward(request, response);
    }
}
