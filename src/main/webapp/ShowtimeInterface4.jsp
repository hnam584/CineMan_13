<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${showtimes == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>2. Showtime Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 900px; padding: 20px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .btn { border: 1px solid #000; padding: 6px 20px; text-decoration: none; color: #000; background: #fff; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; text-align: right; }
        .empty { text-align: center; padding: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Lịch chiếu của phim: <c:out value="${movieId}"/></h3>

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
                        <th>Giá vé</th>
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
                            <td><c:out value="${s.roomId}"/></td>
                            <td><fmt:formatNumber value="${s.ticketPrice}" pattern="#,###"/> đ</td>
                            <td>
                                <a class="btn btn-yellow"
                                   href="${pageContext.request.contextPath}/seats?showtimeId=${s.showtimeId}">Chọn</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="bottom-bar">
        <a href="${pageContext.request.contextPath}/movies" class="btn">Quay lại</a>
    </div>
</div>
</body>
</html>
