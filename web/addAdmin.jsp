<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Check if admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Admin</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link active" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Add New Admin</h2>

        <form action="AddAdminServlet" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <input type="submit" class="btn btn-warning" value="Add Admin">
        </form>

        <h2>Admin List</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT admin_id, username FROM admins ORDER BY admin_id ASC";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        boolean isFirstRow = true; // Track first row

                        while (rs.next()) {
                            if (isFirstRow) {
                                isFirstRow = false; // Skip first row
                                continue;
                            }
                %>
                <tr>
                    <td><%= rs.getString("username") %></td>
                    <td>
                        <form action="DeleteAdminServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this admin?');">
                            <input type="hidden" name="admin_id" value="<%= rs.getInt("admin_id") %>">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='2'>Error loading admins.</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <br>
        <a href="adminDashboard.jsp" class="btn btn-warning">Back to Dashboard</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>