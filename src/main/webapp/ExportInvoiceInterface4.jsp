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
        .container { border: 2px solid #000; width: 760px; padding: 20px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; text-align: center; }
        .money { text-align: right; padding-right: 22px; white-space: nowrap; }
        .invoice-info p { margin: 6px 0; }
        .btn { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; background: #fff; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; text-align: right; }
        .error { color: #b00000; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Hóa đơn và vé</h3>

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
            <div class="invoice-info">
                <p><b>Mã hóa đơn:</b> <c:out value="${invoice.code}"/></p>
                <p><b>Khách hàng:</b> <c:out value="${invoice.customer.fullName}"/></p>
                <p><b>Ngày thanh toán:</b>
                    <fmt:formatDate value="${invoice.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>
                </p>
                <p><b>Ưu đãi:</b>
                    <c:choose>
                        <c:when test="${appliedDiscount}">Giảm 10% (thẻ thành viên hợp lệ)</c:when>
                        <c:otherwise>Không áp dụng</c:otherwise>
                    </c:choose>
                </p>
                <p><b>Tổng tiền:</b>
                    <fmt:formatNumber value="${invoice.totalAmount}" pattern="#,###"/> đ
                </p>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>TT</th>
                        <th>Mã vé</th>
                        <th>Phim</th>
                        <th>Suất chiếu</th>
                        <th>Ghế</th>
                        <th class="money">Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ticket" items="${invoice.tickets}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>VE${ticket.id}</td>
                            <td><c:out value="${showtime.movie.movieName}"/></td>
                            <td><fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><c:out value="${ticket.seat.label}"/></td>
                            <td class="money"><fmt:formatNumber value="${ticket.price}" pattern="#,###"/> đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <p style="text-align: center; font-weight: bold;">Mua vé thành công!</p>

            <div class="bottom-bar">
                <a class="btn btn-yellow" href="${pageContext.request.contextPath}/movies">Về danh sách phim</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
