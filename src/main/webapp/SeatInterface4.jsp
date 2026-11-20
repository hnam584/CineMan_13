<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% request.setAttribute("requiredRole", "CUSTOMER"); %>
<%@ include file="/WEB-INF/auth.jsp" %>
<%@ page import="java.util.List,java.util.Set,dao4.SeatDAO4,dao4.ShowtimeDAO4,dao4.TicketDAO4,model4.Seat4,model4.Showtime4" %>
<fmt:setLocale value="vi_VN"/>
<%
int showtimeId = 0;
try {
    showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
} catch (Exception e) {
    response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
    return;
}
Showtime4 showtime = new ShowtimeDAO4().getShowtimeById4(showtimeId);
if (showtime == null) {
    response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
    return;
}
List<Seat4> seats = new SeatDAO4().getSeatsByRoom4(showtime.getRoom().getId());
Set<Integer> soldSeatIds = new TicketDAO4().getSoldSeatIds4(showtimeId);
for (Seat4 seat : seats) {
    seat.setStatus(soldSeatIds.contains(seat.getId()) ? "DA_BAN" : "TRONG");
}
request.setAttribute("showtime", showtime);
request.setAttribute("seats", seats);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seat Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 900px; padding: 25px; margin: 0 auto; }
        .screen-title { border-bottom: 1px solid #000; margin: -25px -25px 18px; padding: 6px 10px; text-align: center; font-size: 16px; }
        h3 { text-align: center; margin-top: 0; }
        .seat-area { display: flex; align-items: flex-start; gap: 40px; margin: 25px 0; }
        .seat-map { display: grid; grid-template-columns: repeat(10, 48px); gap: 8px; }
        .seat { position: relative; border: 1px solid #000; height: 34px; line-height: 34px; text-align: center; cursor: pointer; background: #fff; font-size: 13px; user-select: none; }
        .seat input { position: absolute; opacity: 0; pointer-events: none; }
        .seat.sold { background: #4d93d9; color: #000; cursor: not-allowed; }
        .seat.selected { background: #ffff00; font-weight: bold; }
        .legend { padding-top: 5px; }
        .legend div { display: flex; align-items: center; margin-bottom: 18px; }
        .legend .box { width: 70px; height: 30px; border: 1px solid #000; margin-right: 12px; }
        .legend .free { background: #fff; }
        .legend .sold { background: #4d93d9; }
        .legend .chosen { background: #ffff00; }
        .card-row { text-align: center; margin-top: 10px; }
        .card-row label { display: block; margin-bottom: 10px; font-size: 15px; }
        .card-row input { width: 700px; padding: 9px; border: 1px solid #000; }
        .actions { margin-top: 25px; text-align: center; }
        .actions .btn { display: block; width: 320px; margin: 0 auto 12px auto; border: 1px solid #000; padding: 10px 0; text-decoration: none; color: #000; background: #fff; cursor: pointer; font-size: 14px; }
        .actions .btn-yellow { background: #ffff00; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="screen-title">Seat Interface 4</div>
    <h3>Sơ đồ ghế - Phòng <c:out value="${showtime.room.label}"/> -
        <fmt:formatDate value="${showtime.startTime}" pattern="HH:mm"/></h3>

    <form action="${pageContext.request.contextPath}/PaymentInterface4.jsp" method="post" onsubmit="return validateSeats();">
        <input type="hidden" name="showtimeId" value="${showtime.id}" />

        <div class="seat-area">
            <div class="seat-map">
                <c:forEach var="seat" items="${seats}">
                    <label class="seat ${seat.available ? '' : 'sold'}">
                        <input type="checkbox" name="seatIds" value="${seat.id}" ${seat.available ? '' : 'disabled'} />
                        <c:out value="${seat.label}"/>
                    </label>
                </c:forEach>
            </div>

            <div class="legend">
                <div><span class="box free"></span> Ghế trống</div>
                <div><span class="box sold"></span> Đã bán</div>
                <div><span class="box chosen"></span> Đang chọn</div>
            </div>
        </div>

        <div class="card-row">
            <label>Mã khách hàng thân thiết (Nếu có)</label>
            <input type="text" name="cardId" value="" />
        </div>

        <div class="actions">
            <button type="submit" class="btn btn-yellow">Xác nhận mua vé</button>
            <a class="btn" href="${pageContext.request.contextPath}/ShowtimeInterface4.jsp?movieId=${showtime.movie.id}">Quay lại</a>
        </div>
    </form>
</div>

<script>
    document.querySelectorAll('.seat input[type="checkbox"]').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            checkbox.closest('.seat').classList.toggle('selected', checkbox.checked);
        });
    });

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
