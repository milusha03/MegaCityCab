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
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Add New Admin</h2>
    
    <form action="AddAdminServlet" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>
        <label>Password:</label>
        <input type="password" name="password" required>
        <input type="submit" value="Add Admin">
    </form>

    <h2>Admin List</h2>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Action</th>
        </tr>

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
                    <input type="submit" value="Delete">
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
    </table>

    <br>
    <a href="adminDashboard.jsp">Back to Dashboard</a>
</body>
</html>
