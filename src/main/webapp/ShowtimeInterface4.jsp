<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.util.List,dao4.MovieDAO4,dao4.ShowtimeDAO4,model4.Movie4,model4.Showtime4" %>
<fmt:setLocale value="vi_VN"/>
<%
int movieId = 0;
try {
    movieId = Integer.parseInt(request.getParameter("movieId"));
} catch (Exception e) {
    response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
    return;
}
Movie4 movie = new MovieDAO4().getMovieById4(movieId);
if (movie == null) {
    response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
    return;
}
List<Showtime4> showtimes = new ShowtimeDAO4().getShowtimesByMovie4(movieId);
request.setAttribute("movie", movie);
request.setAttribute("showtimes", showtimes);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Showtime Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 900px; padding: 20px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .money { text-align: right; padding-right: 22px; white-space: nowrap; }
        .btn { border: 1px solid #000; padding: 6px 20px; text-decoration: none; color: #000; background: #fff; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; text-align: right; }
        .empty { text-align: center; padding: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Lịch chiếu của phim: <c:out value="${movie.movieName}"/></h3>

    <c:choose>
        <c:when test="${empty showtimes}">
            <p class="empty">Phim hiện chưa có suất chiếu.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>TT</th>
                        <th>Ngày chiếu</th>
                        <th>Giờ bắt đầu</th>
                        <th>Giờ kết thúc</th>
                        <th>Phòng</th>
                        <th class="money">Giá vé</th>
                        <th>Chọn</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${showtimes}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><fmt:formatDate value="${s.startTime}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${s.startTime}" pattern="HH:mm"/></td>
                            <td><fmt:formatDate value="${s.endTime}" pattern="HH:mm"/></td>
                            <td><c:out value="${s.room.label}"/></td>
                            <td class="money"><fmt:formatNumber value="${s.ticketPrice}" pattern="#,###"/> đ</td>
                            <td>
                                <a class="btn btn-yellow"
                                   href="${pageContext.request.contextPath}/SeatInterface4.jsp?showtimeId=${s.id}">Chọn</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="bottom-bar">
        <a href="${pageContext.request.contextPath}/ListMovieInterface4.jsp" class="btn">Quay lại</a>
    </div>
</div>
</body>
</html>
