<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>
<c:if test="${showtime == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Export Invoice Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 760px; margin: 0 auto; }
        .screen-title { border-bottom: 1px solid #000; padding: 6px 10px; text-align: center; font-size: 16px; }
        .content { padding: 18px 30px 25px; }
        h3 { text-align: center; margin: 14px 0 12px; }
        table { border-collapse: collapse; margin: 0 auto 18px; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 7px 10px; text-align: center; }
        .ticket-table { width: 80%; }
        .invoice-table { width: 55%; }
        .invoice-table td:first-child { text-align: left; }
        .invoice-table td:last-child { text-align: center; }
        .bottom-bar { margin-top: 28px; text-align: center; }
        .btn { display: inline-block; border: 1px solid #000; padding: 8px 45px; text-decoration: none; color: #000; background: #fff; cursor: pointer; font-size: 14px; }
        .error { color: #b00000; font-weight: bold; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <div class="screen-title">Export Invoice Interface 4</div>
    <div class="content">
        <c:choose>
            <c:when test="${invalidSeat}">
                <p class="error">
                    <c:choose>
                        <c:when test="${not empty conflict}"><c:out value="${conflict}"/></c:when>
                        <c:otherwise>Ghế bạn chọn đã được bán hoặc không hợp lệ. Vui lòng chọn lại.</c:otherwise>
                    </c:choose>
                </p>
                <div class="bottom-bar">
                    <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.id}">Chọn lại ghế</a>
                </div>
            </c:when>
            <c:when test="${not saved}">
                <p class="error">Thanh toán chưa hoàn tất: không thể lưu hóa đơn. Vui lòng thử lại.</p>
                <div class="bottom-bar">
                    <a class="btn" href="${pageContext.request.contextPath}/movies">Thử lại</a>
                </div>
            </c:when>
            <c:otherwise>
                <h3>Danh sách vé</h3>
                <table class="ticket-table">
                    <thead>
                        <tr>
                            <th>TT</th>
                            <th>Phim</th>
                            <th>Suất chiếu</th>
                            <th>Ghế</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ticket" items="${invoice.tickets}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td><c:out value="${showtime.movie.movieName}"/></td>
                                <td><fmt:formatDate value="${showtime.startTime}" pattern="HH:mm - d/M/yyyy"/></td>
                                <td><c:out value="${ticket.seat.label}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <h3>Hóa đơn</h3>
                <table class="invoice-table">
                    <tr>
                        <td>Mã hóa đơn</td>
                        <td><c:out value="${invoice.code}"/></td>
                    </tr>
                    <tr>
                        <td>Tổng tiền</td>
                        <td><fmt:formatNumber value="${invoice.totalAmount}" pattern="#,###"/> đ</td>
                    </tr>
                    <tr>
                        <td>Ngày tạo</td>
                        <td><fmt:formatDate value="${invoice.paymentDate}" pattern="d/M/yyyy"/></td>
                    </tr>
                </table>

                <div class="bottom-bar">
                    <button type="button" class="btn" onclick="window.print()">In hóa đơn</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
