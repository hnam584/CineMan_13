<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<fmt:setLocale value="vi_VN"/>
<c:if test="${showtime == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 760px; padding: 20px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; text-align: center; }
        .money { text-align: right; padding-right: 22px; white-space: nowrap; }
        .summary { margin: 20px 0; font-size: 16px; }
        .summary p { margin: 6px 0; }
        .btn { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; background: #fff; cursor: pointer; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; display: flex; justify-content: space-between; }
        .error { color: #b00000; font-weight: bold; }
        .payment-code { margin: 10px 0 18px; }
        .payment-code p { margin: 6px 0; }
        .payment-code .code { font-size: 20px; font-weight: bold; letter-spacing: 2px; }
        .confirm-row { margin: 12px 0; }
        .confirm-row input { width: 220px; padding: 6px; font-size: 16px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Thông tin thanh toán</h3>

    <c:choose>
        <c:when test="${invalidSeat}">
            <p class="error">Một hoặc nhiều ghế bạn chọn đã được bán. Vui lòng chọn lại ghế khác.</p>
            <div class="bottom-bar">
                <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.id}">Chọn lại ghế</a>
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
                        <th class="money">Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seat" items="${selectedSeats}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${showtime.movie.movieName}"/></td>
                            <td><fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><c:out value="${showtime.room.label}"/></td>
                            <td><c:out value="${seat.label}"/></td>
                            <td class="money"><fmt:formatNumber value="${unitPrice}" pattern="#,###"/> đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="summary">
                <p><b>Khách hàng:</b> <c:out value="${sessionScope.member.fullName}"/></p>
                <p><b>Mã thẻ thành viên:</b>
                    <c:choose>
                        <c:when test="${empty cardId}">Không có</c:when>
                        <c:otherwise><c:out value="${cardId}"/></c:otherwise>
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

            <div class="payment-code">
                <p><b>Mã thanh toán:</b>
                    <span class="code"><c:out value="${paymentCode}"/></span>
                </p>
                <c:if test="${not empty codeError}">
                    <p class="error"><c:out value="${codeError}"/></p>
                </c:if>
            </div>

            <form action="${pageContext.request.contextPath}/invoice" method="post">
                <input type="hidden" name="showtimeId" value="${showtime.id}" />
                <input type="hidden" name="cardId" value="${cardId}" />
                <c:forEach var="seat" items="${selectedSeats}">
                    <input type="hidden" name="seatIds" value="${seat.id}" />
                </c:forEach>
                <p class="confirm-row">
                    <label for="confirmCode"><b>Nhập mã xác nhận thanh toán:</b></label>
                    <input type="text" id="confirmCode" name="confirmCode" maxlength="9"
                           inputmode="numeric" autocomplete="off" required />
                </p>
                <div class="bottom-bar">
                    <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.id}">Quay lại</a>
                    <button type="submit" class="btn btn-yellow">Xác nhận thanh toán</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
