<%
    session.invalidate();
    response.sendRedirect("login.jsp?message=Logged out successfully");
%>
