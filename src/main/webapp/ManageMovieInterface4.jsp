<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${movies == null}"><c:redirect url="/manage-movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>2. Manage Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 800px; padding: 20px; margin: 0 auto; }
        .top-bar { display: flex; justify-content: flex-end; margin-bottom: 15px; gap: 15px; }
        .btn-tab { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; }
        .btn-yellow { background-color: #ffff00; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .btn-action { display: inline-block; padding: 4px 12px; background-color: #ffff00; border: 1px solid #000; text-decoration: none; color: #000; }
        .bottom-bar { margin-top: 25px; text-align: right; }
        .btn-back { border: 1px solid #000; padding: 6px 30px; text-decoration: none; color: #000; background: #fff; }
        .empty { text-align: center; padding: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">2. Manage Movie Interface 4</h3>

    <div class="top-bar">
        <span class="btn-tab">Danh sách phim</span>
        <a href="${pageContext.request.contextPath}/add-movie" class="btn-tab btn-yellow">Thêm phim</a>
    </div>

    <c:choose>
        <c:when test="${empty movies}">
            <p class="empty">Chưa có phim nào trong hệ thống.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th style="width: 8%;">TT</th>
                        <th>Tên Phim</th>
                        <th>Thể loại</th>
                        <th>Thời lượng</th>
                        <th style="width: 12%;">Sửa</th>
                        <th style="width: 12%;">Xóa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${movies}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${m.movieName}"/></td>
                            <td><c:out value="${m.genre}"/></td>
                            <td>${m.duration} phút</td>
                            <td><a href="#" class="btn-action">Sửa</a></td>
                            <td><a href="#" class="btn-action">Xóa</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="bottom-bar">
        <a href="${pageContext.request.contextPath}/CinemaInterface4.jsp" class="btn-back">Quay lại</a>
    </div>
</div>
</body>
</html>
