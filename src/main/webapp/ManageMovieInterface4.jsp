<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% request.setAttribute("requiredRole", "MANAGER"); %>
<%@ include file="/WEB-INF/auth.jsp" %>
<%@ page import="java.util.List,dao4.MovieDAO4,model4.Movie4" %>
<%
List<Movie4> movies = new MovieDAO4().getAllMovies4();
request.setAttribute("movies", movies);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 800px; padding: 20px; margin: 0 auto; }
        .list-header { position: relative; text-align: center; margin-bottom: 15px; min-height: 36px; }
        .list-title { font-weight: bold; font-size: 16px; line-height: 36px; }
        .btn-add { position: absolute; right: 0; top: 0; border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; background: #ffff00; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .btn-action { display: inline-block; padding: 4px 12px; border: 1px solid #000; text-decoration: none; color: #000; background: #e0e0e0; }
        .btn-action.disabled { color: #888; cursor: not-allowed; }
        .bottom-bar { margin-top: 25px; text-align: right; }
        .btn-back { border: 1px solid #000; padding: 6px 30px; text-decoration: none; color: #000; background: #fff; }
        .empty { text-align: center; padding: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Manage Movie Interface 4</h3>

    <div class="list-header">
        <span class="list-title">Danh sách phim</span>
        <a href="${pageContext.request.contextPath}/AddMovieInterface4.jsp" class="btn-add">Thêm phim</a>
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
                            <td><span class="btn-action disabled" title="Chưa hỗ trợ">Sửa</span></td>
                            <td><span class="btn-action disabled" title="Chưa hỗ trợ">Xóa</span></td>
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
