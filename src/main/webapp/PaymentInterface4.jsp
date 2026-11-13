<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:if test="${showtime == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>4. Payment Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 760px; padding: 20px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; text-align: center; }
        .summary { margin: 20px 0; font-size: 16px; }
        .summary p { margin: 6px 0; }
        .btn { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; background: #fff; cursor: pointer; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; display: flex; justify-content: space-between; }
        .error { color: #b00000; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Thông tin thanh toán</h3>

    <c:choose>
        <c:when test="${invalidSeat}">
            <p class="error">Một hoặc nhiều ghế bạn chọn đã được bán. Vui lòng chọn lại ghế khác.</p>
            <div class="bottom-bar">
                <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.showtimeId}">Chọn lại ghế</a>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>TT</th>
                        <th>Phim</th>
                        <th>Suất chiếu</th>
                        <th>Phòng</th>
                        <th>Ghế</th>
                        <th>Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seat" items="${selectedSeats}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${showtime.movieId}"/></td>
                            <td><fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><c:out value="${showtime.roomId}"/></td>
                            <td><c:out value="${seat.seatId}"/></td>
                            <td><fmt:formatNumber value="${unitPrice}" pattern="#,###"/> đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="summary">
                <p><b>Khách hàng:</b> Customer A</p>
                <p><b>Mã thẻ thành viên:</b>
                    <c:choose>
                        <c:when test="${empty loyaltyCode}">Không có</c:when>
                        <c:otherwise><c:out value="${loyaltyCode}"/></c:otherwise>
                    </c:choose>
                </p>
                <p><b>Ưu đãi:</b>
                    <c:choose>
                        <c:when test="${appliedDiscount}">Giảm 10% (thẻ thành viên hợp lệ)</c:when>
                        <c:otherwise>Không áp dụng</c:otherwise>
                    </c:choose>
                </p>
                <p><b>Số ghế:</b> ${fn:length(selectedSeats)}</p>
                <p style="font-size: 20px;"><b>Tổng tiền:</b>
                    <fmt:formatNumber value="${totalAmount}" pattern="#,###"/> đ
                </p>
            </div>

            <form action="${pageContext.request.contextPath}/invoice" method="post">
                <input type="hidden" name="showtimeId" value="${showtime.showtimeId}" />
                <input type="hidden" name="loyaltyCode" value="${loyaltyCode}" />
                <c:forEach var="seat" items="${selectedSeats}">
                    <input type="hidden" name="seatIds" value="${seat.id}" />
                </c:forEach>
                <div class="bottom-bar">
                    <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.showtimeId}">Quay lại</a>
                    <button type="submit" class="btn btn-yellow">Xác nhận thanh toán</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
