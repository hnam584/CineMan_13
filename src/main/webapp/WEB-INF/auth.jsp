<%@ page import="model4.Member4" %>
<%
Member4 authMember = (Member4) session.getAttribute("member");
if (authMember == null) {
    response.sendRedirect(request.getContextPath() + "/LoginInterface4.jsp");
    return;
}
String requiredRole = (String) request.getAttribute("requiredRole");
if (requiredRole != null && !requiredRole.equals(authMember.getRole())) {
    response.sendRedirect(request.getContextPath() + "/CinemaInterface4.jsp");
    return;
}
%>
