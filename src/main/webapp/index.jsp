<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:choose>
    <c:when test="${not empty sessionScope.member}">
        <c:redirect url="/CinemaInterface4.jsp"/>
    </c:when>
    <c:otherwise>
        <c:redirect url="/LoginInterface4.jsp"/>
    </c:otherwise>
</c:choose>
