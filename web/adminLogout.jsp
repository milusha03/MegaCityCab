<%@ page session="true" %>
<%
    session.invalidate();
    response.sendRedirect("adminLogin.jsp");
%>
