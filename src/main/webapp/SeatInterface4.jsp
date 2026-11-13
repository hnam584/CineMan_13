<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${showtime == null}"><c:redirect url="/movies"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>3. Seat Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 850px; padding: 20px; margin: 0 auto; }
        .screen { background: #ddd; border: 1px solid #000; text-align: center; padding: 8px; margin: 20px 0; }
        .seat-map { display: grid; grid-template-columns: repeat(10, 1fr); gap: 8px; margin: 20px 0; }
        .seat { border: 1px solid #000; padding: 10px 4px; text-align: center; cursor: pointer; }
        .seat.available { background: #fff; }
        .seat.sold { background: #999; color: #fff; cursor: not-allowed; }
        .seat input { margin-right: 4px; }
        .info { margin: 15px 0; }
        .btn { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; background: #fff; cursor: pointer; }
        .btn-yellow { background: #ffff00; font-weight: bold; }
        .bottom-bar { margin-top: 20px; display: flex; justify-content: space-between; align-items: center; }
        .legend span { margin-right: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Sơ đồ ghế - Phòng <c:out value="${showtime.roomId}"/></h3>
    <div class="info">
        <b>Phim:</b> <c:out value="${showtime.movieId}"/> &nbsp; | &nbsp;
        <b>Suất chiếu:</b> <fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/> &nbsp; | &nbsp;
        <b>Giá vé:</b> <fmt:formatNumber value="${showtime.ticketPrice}" pattern="#,###"/> đ
    </div>

    <div class="screen">MÀN HÌNH</div>

    <form action="${pageContext.request.contextPath}/payment" method="post" onsubmit="return validateSeats();">
        <input type="hidden" name="showtimeId" value="${showtime.showtimeId}" />

        <div class="seat-map">
            <c:forEach var="seat" items="${seats}">
                <c:choose>
                    <c:when test="${seat.available}">
                        <label class="seat available">
                            <input type="checkbox" name="seatIds" value="${seat.id}" />
                            <c:out value="${seat.seatId}"/>
                        </label>
                    </c:when>
                    <c:otherwise>
                        <label class="seat sold">
                            <input type="checkbox" name="seatIds" value="${seat.id}" disabled />
                            <c:out value="${seat.seatId}"/>
                        </label>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <div class="legend">
            <span>⬜ Ghế trống</span>
            <span>⬛ Đã bán</span>
        </div>

        <div style="margin-top: 20px;">
            <label>Mã thẻ thành viên (nếu có): </label>
            <input type="text" name="loyaltyCode" value="" />
        </div>

        <div class="bottom-bar">
            <a class="btn" href="${pageContext.request.contextPath}/showtimes?movieId=${showtime.movieId}">Quay lại</a>
            <button type="submit" class="btn btn-yellow">Xác nhận mua vé</button>
        </div>
    </form>
</div>

<script>
    function validateSeats() {
        var checked = document.querySelectorAll('input[name="seatIds"]:checked').length;
        if (checked === 0) {
            alert('Vui lòng chọn ít nhất một ghế trống.');
            return false;
        }
        return true;
    }
</script>
</body>
</html>
