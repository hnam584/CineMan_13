<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>3. Add Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 650px; padding: 25px; margin: 0 auto; position: relative; }
        .form-group { display: flex; margin-bottom: 18px; align-items: center; }
        .form-group label { width: 140px; font-weight: bold; }
        .form-group input[type="text"], .form-group textarea { flex: 1; padding: 8px; border: 1px solid #000; font-family: inherit; }
        .form-group input.short-input { width: 160px; flex: none; }
        .btn-group { display: flex; justify-content: flex-end; gap: 15px; margin-top: 25px; }
        .btn { border: 1px solid #000; padding: 8px 30px; cursor: pointer; text-decoration: none; color: #000; font-size: 14px; }
        .btn-submit { background-color: #e0e0e0; }
        .btn-yellow { background-color: #ffff00; font-weight: bold; }
        .modal-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; }
        .modal-box { background: #fff; border: 2px solid #000; padding: 30px; text-align: center; width: 320px; box-shadow: 2px 2px 10px rgba(0,0,0,0.2); }
        .modal-msg { border: 1px solid #000; padding: 12px; margin-bottom: 20px; background: #fff; }
        .error { color: #b00000; font-weight: bold; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">3. Add Movie Interface 4</h3>
    <p style="font-weight: bold; margin-bottom: 20px;">Thêm thông tin phim</p>

    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <form action="${pageContext.request.contextPath}/add-movie" method="post">
        <div class="form-group">
            <label>Tên phim</label>
            <input type="text" name="inName" required />
        </div>
        <div class="form-group">
            <label>Thể loại</label>
            <input type="text" name="inGenre" required />
        </div>
        <div class="form-group">
            <label>Thời lượng</label>
            <input type="text" name="inDuration" class="short-input" required />
            <span style="margin-left: 10px;">(Phút)</span>
        </div>
        <div class="form-group" style="align-items: flex-start;">
            <label style="margin-top: 5px;">Mô tả</label>
            <textarea name="inDescription" rows="5"></textarea>
        </div>
        <div class="btn-group">
            <input type="submit" value="Thêm" class="btn btn-submit" />
            <a href="${pageContext.request.contextPath}/manage-movies" class="btn btn-yellow">Quay lại</a>
        </div>
    </form>

    <c:if test="${not empty success}">
        <div class="modal-overlay">
            <div class="modal-box">
                <h4 style="margin-top: 0;">4. Notify Success</h4>
                <div class="modal-msg"><c:out value="${success}"/></div>
                <a href="${pageContext.request.contextPath}/manage-movies" class="btn btn-yellow" style="display: inline-block;">OK</a>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
