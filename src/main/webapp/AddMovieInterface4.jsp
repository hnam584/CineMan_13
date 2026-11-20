<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% request.setAttribute("requiredRole", "MANAGER"); %>
<%@ include file="/WEB-INF/auth.jsp" %>
<%@ page import="dao4.MovieDAO4,model4.Manager4,model4.Member4,model4.Movie4" %>
<%
request.setCharacterEncoding("UTF-8");
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("inName");
    String genre = request.getParameter("inGenre");
    String durationText = request.getParameter("inDuration");
    String description = request.getParameter("inDescription");

    if (name == null || name.trim().isEmpty()) {
        request.setAttribute("error", "Vui lòng nhập tên phim.");
    } else {
        int duration;
        try {
            duration = Integer.parseInt(durationText);
            if (duration <= 0) {
                throw new NumberFormatException();
            }
        } catch (Exception e) {
            request.setAttribute("error", "Thời lượng phải là số nguyên dương.");
            duration = 0;
        }

        if (duration > 0) {
            Member4 member = (Member4) session.getAttribute("member");
            Movie4 movie = new Movie4(name.trim(), genre, duration, description);
            if (member instanceof Manager4) {
                movie.setManager((Manager4) member);
            }
            boolean added = new MovieDAO4().addMovie4(movie);
            if (added) {
                request.setAttribute("success", "Thêm phim thành công.");
            } else {
                request.setAttribute("error", "Thêm phim thất bại. Vui lòng thử lại.");
            }
        }
    }
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 650px; padding: 25px; margin: 0 auto; position: relative; }
        .form-group { display: flex; margin-bottom: 18px; align-items: center; }
        .form-group label { width: 140px; font-weight: bold; }
        .form-group input[type="text"], .form-group textarea { flex: 1; padding: 8px; border: 1px solid #000; font-family: inherit; }
        .form-group input.short-input { width: 160px; flex: none; }
        .btn-group { display: flex; justify-content: flex-end; gap: 15px; margin-top: 25px; }
        .btn { border: 1px solid #000; padding: 8px 30px; cursor: pointer; text-decoration: none; color: #000; font-size: 14px; background: #e0e0e0; }
        .btn:disabled { color: #888; cursor: not-allowed; }
        .btn-yellow { background-color: #ffff00; font-weight: bold; color: #000; }
        .modal-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; }
        .modal-box { background: #fff; border: 2px solid #000; padding: 30px; text-align: center; width: 320px; box-shadow: 2px 2px 10px rgba(0,0,0,0.2); }
        .modal-msg { border: 1px solid #000; padding: 12px; margin-bottom: 20px; background: #fff; }
        .error { color: #b00000; font-weight: bold; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Add Movie Interface 4</h3>
    <p style="font-weight: bold; margin-bottom: 20px;">Thêm thông tin phim</p>

    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <form action="${pageContext.request.contextPath}/AddMovieInterface4.jsp" method="post">
        <div class="form-group">
            <label>Tên phim</label>
            <input type="text" id="inName" name="inName" required />
        </div>
        <div class="form-group">
            <label>Thể loại</label>
            <input type="text" id="inGenre" name="inGenre" required />
        </div>
        <div class="form-group">
            <label>Thời lượng</label>
            <input type="text" id="inDuration" name="inDuration" class="short-input" required />
            <span style="margin-left: 10px;">(Phút)</span>
        </div>
        <div class="form-group" style="align-items: flex-start;">
            <label style="margin-top: 5px;">Mô tả</label>
            <textarea id="inDescription" name="inDescription" rows="5"></textarea>
        </div>
        <div class="btn-group">
            <input type="submit" id="btnAdd" value="Thêm" class="btn" disabled />
            <a href="${pageContext.request.contextPath}/ManageMovieInterface4.jsp" class="btn btn-yellow">Quay lại</a>
        </div>
    </form>

    <c:if test="${not empty success}">
        <div class="modal-overlay">
            <div class="modal-box">
                <h4 style="margin-top: 0;">Notify Success</h4>
                <div class="modal-msg"><c:out value="${success}"/></div>
                <a href="${pageContext.request.contextPath}/ManageMovieInterface4.jsp" class="btn btn-yellow" style="display: inline-block;">OK</a>
            </div>
        </div>
    </c:if>
</div>

<script>
    (function () {
        var name = document.getElementById('inName');
        var genre = document.getElementById('inGenre');
        var duration = document.getElementById('inDuration');
        var description = document.getElementById('inDescription');
        var btn = document.getElementById('btnAdd');

        function filled(el) {
            return el && el.value.trim().length > 0;
        }

        function validDuration() {
            var value = duration.value.trim();
            return /^\d+$/.test(value) && parseInt(value, 10) > 0;
        }

        function refresh() {
            var ok = filled(name) && filled(genre) && validDuration() && filled(description);
            btn.disabled = !ok;
            if (ok) {
                btn.classList.add('btn-yellow');
            } else {
                btn.classList.remove('btn-yellow');
            }
        }

        [name, genre, duration, description].forEach(function (el) {
            el.addEventListener('input', refresh);
            el.addEventListener('change', refresh);
        });
        refresh();
    })();
</script>
</body>
</html>
