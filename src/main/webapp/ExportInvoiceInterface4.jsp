<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<% request.setAttribute("requiredRole", "CUSTOMER"); %>
<%@ include file="/WEB-INF/auth.jsp" %>
<%@ page import="java.sql.Timestamp,java.util.ArrayList,java.util.HashSet,java.util.List,java.util.Set,java.util.TreeSet,dao4.InvoiceDAO4,dao4.MembershipCardDAO4,dao4.SeatDAO4,dao4.ShowtimeDAO4,dao4.TicketDAO4,model4.Customer4,model4.Invoice4,model4.Member4,model4.Seat4,model4.Showtime4,model4.Ticket4" %>
<fmt:setLocale value="vi_VN"/>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    Member4 member = (Member4) session.getAttribute("member");
    if (!(member instanceof Customer4)) {
        response.sendRedirect(request.getContextPath() + "/CinemaInterface4.jsp");
        return;
    }
    Customer4 customer = (Customer4) member;

    int showtimeId;
    try {
        showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
        return;
    }

    String[] seatIdParams = request.getParameterValues("seatIds");
    if (seatIdParams == null || seatIdParams.length == 0) {
        response.sendRedirect(request.getContextPath() + "/SeatInterface4.jsp?showtimeId=" + showtimeId);
        return;
    }

    Showtime4 showtime = new ShowtimeDAO4().getShowtimeById4(showtimeId);
    if (showtime == null) {
        response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
        return;
    }

    List<Seat4> allSeats = new SeatDAO4().getSeatsByRoom4(showtime.getRoom().getId());
    TicketDAO4 ticketDAO = new TicketDAO4();
    Set<Integer> soldSeatIds = ticketDAO.getSoldSeatIds4(showtimeId);
    Set<Integer> selectedIds = new HashSet<>();
    for (String value : seatIdParams) {
        try {
            selectedIds.add(Integer.parseInt(value));
        } catch (NumberFormatException ignored) {
        }
    }

    List<Seat4> selectedSeats = new ArrayList<>();
    boolean invalidSeat = false;
    for (Seat4 seat : allSeats) {
        if (selectedIds.contains(seat.getId())) {
            selectedSeats.add(seat);
            if (soldSeatIds.contains(seat.getId())) {
                invalidSeat = true;
            }
        }
    }
    if (selectedSeats.size() != selectedIds.size()) {
        invalidSeat = true;
    }

    String cardIdText = request.getParameter("cardId");
    boolean appliedDiscount = false;
    if (cardIdText != null && !cardIdText.trim().isEmpty()) {
        try {
            appliedDiscount = new MembershipCardDAO4().checkValid4(Integer.parseInt(cardIdText.trim()));
        } catch (NumberFormatException ignored) {
        }
    }

    float unitPrice = ticketDAO.calculatePrice4(showtime.getTicketPrice());
    if (appliedDiscount) {
        unitPrice = unitPrice * 0.9f;
    }

    String expectedCode = (String) session.getAttribute("paymentCode");
    Integer paidShowtimeId = (Integer) session.getAttribute("paymentShowtimeId");
    String paidSeatIds = (String) session.getAttribute("paymentSeatIds");
    String enteredCode = request.getParameter("confirmCode");
    String currentSeatIds = new TreeSet<>(selectedIds).toString();
    boolean validConfirmation = expectedCode != null
            && enteredCode != null
            && expectedCode.equals(enteredCode.trim())
            && paidShowtimeId != null
            && paidShowtimeId.intValue() == showtimeId
            && currentSeatIds.equals(paidSeatIds);

    if (!invalidSeat && !validConfirmation) {
        request.setAttribute("showtime", showtime);
        request.setAttribute("selectedSeats", selectedSeats);
        request.setAttribute("cardId", cardIdText == null ? "" : cardIdText.trim());
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("unitPrice", unitPrice);
        request.setAttribute("totalAmount", unitPrice * selectedSeats.size());
        request.setAttribute("paymentCode", expectedCode);
        request.setAttribute("codeError", "Mã xác nhận thanh toán không đúng. Vui lòng nhập lại.");
        request.getRequestDispatcher("/PaymentInterface4.jsp").forward(request, response);
        return;
    }

    session.removeAttribute("paymentCode");
    session.removeAttribute("paymentShowtimeId");
    session.removeAttribute("paymentSeatIds");

    boolean saved = false;
    Invoice4 invoice = null;
    if (!invalidSeat) {
        invoice = new Invoice4();
        invoice.setCustomer(customer);
        invoice.setSalesStaff(null);
        invoice.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        for (Seat4 seat : selectedSeats) {
            Ticket4 ticket = new Ticket4();
            ticket.setPrice(unitPrice);
            ticket.setStatus("DA_BAN");
            ticket.setShowtime(showtime);
            ticket.setSeat(seat);
            ticket.setCustomer(customer);
            invoice.getTickets().add(ticket);
        }
        InvoiceDAO4 invoiceDAO = new InvoiceDAO4();
        invoice.setTotalAmount(invoiceDAO.calculateTotalAmount4(invoice.getTickets()));
        saved = invoiceDAO.addInvoice4(invoice);
        if (saved) {
            invoiceDAO.printInvoice4();
        } else {
            Set<Integer> soldNow = ticketDAO.getSoldSeatIds4(showtimeId);
            for (Seat4 seat : selectedSeats) {
                if (soldNow.contains(seat.getId())) {
                    invalidSeat = true;
                    request.setAttribute("conflict", "Một hoặc nhiều ghế vừa được người khác đặt. Vui lòng chọn lại ghế.");
                    break;
                }
            }
        }
    }

    request.setAttribute("showtime", showtime);
    request.setAttribute("invoice", invoice);
    request.setAttribute("appliedDiscount", appliedDiscount);
    request.setAttribute("invalidSeat", invalidSeat);
    request.setAttribute("saved", saved);
} else if (request.getAttribute("invoice") == null) {
    response.sendRedirect(request.getContextPath() + "/ListMovieInterface4.jsp");
    return;
}
%>
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
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.35); align-items: center; justify-content: center; }
        .modal-overlay.show { display: flex; }
        .modal-box { width: 520px; background: #fff; border: 2px solid #000; }
        .modal-title { border-bottom: 1px solid #000; padding: 6px 10px; text-align: center; font-size: 16px; }
        .modal-content { padding: 30px; text-align: center; }
        .modal-msg { border: 1px solid #000; padding: 12px 10px; margin-bottom: 22px; }
        .modal-btn { width: 180px; border: 1px solid #000; padding: 8px; background: #ffff00; font-weight: bold; cursor: pointer; font-size: 14px; }
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
                    <a class="btn" href="${pageContext.request.contextPath}/SeatInterface4.jsp?showtimeId=${showtime.id}">Chọn lại ghế</a>
                </div>
            </c:when>
            <c:when test="${not saved}">
                <p class="error">Thanh toán chưa hoàn tất: không thể lưu hóa đơn. Vui lòng thử lại.</p>
                <div class="bottom-bar">
                    <a class="btn" href="${pageContext.request.contextPath}/ListMovieInterface4.jsp">Thử lại</a>
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
                    <button type="button" class="btn" onclick="showSuccess()">In hóa đơn</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div id="successModal" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-title">Notify Success</div>
        <div class="modal-content">
            <div class="modal-msg">Mua vé thành công</div>
            <button type="button" class="modal-btn"
                    onclick="location.href='${pageContext.request.contextPath}/ListMovieInterface4.jsp'">OK</button>
        </div>
    </div>
</div>

<script>
    function showSuccess() {
        document.getElementById('successModal').classList.add('show');
    }
</script>
</body>
</html>
