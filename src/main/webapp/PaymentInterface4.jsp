<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>
<c:if test="${showtime == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 760px; margin: 0 auto; }
        .screen-title { border-bottom: 1px solid #000; padding: 6px 10px; text-align: center; font-size: 16px; }
        .content { padding: 18px 30px 25px; }
        h3 { text-align: center; margin: 10px 0 22px; }
        .inline-row { display: flex; align-items: center; margin: 18px 0; }
        .inline-row label { width: 260px; }
        .code-value { flex: 1; border: 1px solid #000; padding: 7px 10px; min-height: 20px; text-align: center; }
        .code-value span { font-weight: bold; letter-spacing: 2px; }
        .row label { display: block; margin-bottom: 6px; }
        .confirm-input { width: 100%; box-sizing: border-box; padding: 7px 10px; font-size: 15px; }
        .buttons { margin-top: 22px; text-align: center; }
        .btn { display: block; width: 240px; margin: 10px auto; border: 1px solid #000; padding: 8px 15px; text-decoration: none; color: #000; background: #fff; cursor: pointer; font-size: 14px; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .error { color: #b00000; font-weight: bold; margin: 8px 0; }
    </style>
</head>
<body>
<div class="container">
    <div class="screen-title">Payment Interface 4</div>
    <div class="content">
        <h3>Thông tin thanh toán</h3>

        <c:choose>
            <c:when test="${invalidSeat}">
                <p class="error">Một hoặc nhiều ghế bạn chọn đã được bán. Vui lòng chọn lại ghế khác.</p>
                <div class="buttons">
                    <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.id}">Chọn lại ghế</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="inline-row">
                    <label>Mã thanh toán</label>
                    <div class="code-value"><span><c:out value="${paymentCode}"/></span></div>
                </div>

                <c:if test="${not empty codeError}">
                    <p class="error"><c:out value="${codeError}"/></p>
                </c:if>

                <form action="${pageContext.request.contextPath}/invoice" method="post">
                    <input type="hidden" name="showtimeId" value="${showtime.id}" />
                    <input type="hidden" name="cardId" value="${cardId}" />
                    <c:forEach var="seat" items="${selectedSeats}">
                        <input type="hidden" name="seatIds" value="${seat.id}" />
                    </c:forEach>

                    <div class="row">
                        <label for="confirmCode">Nhập mã xác nhận thanh toán</label>
                        <input type="text" id="confirmCode" name="confirmCode" class="confirm-input"
                               maxlength="9" inputmode="numeric" autocomplete="off" required />
                    </div>

                    <div class="buttons">
                        <button type="submit" class="btn btn-yellow">Xác nhận thanh toán</button>
                        <a class="btn" href="${pageContext.request.contextPath}/seats?showtimeId=${showtime.id}">Quay lại</a>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
