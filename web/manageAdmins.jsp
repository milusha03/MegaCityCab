<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" import="java.sql.*, com.megacitycab.utils.DBConnection" %>

<%
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Admins</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Manage Admins</h2>

    <%-- Display error or success messages --%>
    <% if (request.getParameter("message") != null) { %>
        <p style="color: green;"><%= request.getParameter("message") %></p>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;"><%= request.getParameter("error") %></p>
    <% } %>

    <form action="ManageAdminsServlet" method="post">
        <label>New Admin Username:</label>
        <input type="text" name="new_admin_username" required>

        <label>New Admin Password:</label>
        <input type="password" name="new_admin_password" required>

        <button type="submit">Add Admin</button>
    </form>

    <h3>Existing Admins</h3>
    <table border="1">
        <tr>
            <th>Admin ID</th>
            <th>Username</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT admin_id, username FROM admins")) {
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("admin_id") %></td>
            <td><%= rs.getString("username") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
