<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${movies == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 800px; padding: 20px; margin: 0 auto; }
        .top-bar { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .btn { border: 1px solid #000; padding: 6px 20px; text-decoration: none; color: #000; background: #fff; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .empty { text-align: center; padding: 20px; }
    </style>
</head>
<body>
<div class="container">
    <div class="top-bar">
        <span>Xin chào, <c:out value="${sessionScope.member.fullName}"/></span>
        <a href="${pageContext.request.contextPath}/logout" class="btn">Đăng xuất</a>
    </div>

    <h3 style="text-align: center; margin-top: 0;">Danh sách phim đang chiếu</h3>

    <c:choose>
        <c:when test="${empty movies}">
            <p class="empty">Hiện chưa có phim nào có suất chiếu.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>TT</th>
                        <th>Tên phim</th>
                        <th>Thể loại</th>
                        <th>Thời lượng</th>
                        <th>Chọn</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${movies}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${m.movieName}"/></td>
                            <td><c:out value="${m.genre}"/></td>
                            <td>${m.duration} phút</td>
                            <td>
                                <a class="btn btn-yellow"
                                   href="${pageContext.request.contextPath}/showtimes?movieId=${m.id}">Chọn</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div style="margin-top: 20px; text-align: right;">
        <a href="${pageContext.request.contextPath}/CinemaInterface4.jsp" class="btn">Quay lại</a>
    </div>
</div>
</body>
</html>
