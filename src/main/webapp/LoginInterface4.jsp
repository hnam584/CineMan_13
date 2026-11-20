<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - CineMan</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f2f2; margin: 0; padding: 40px; }
        .box { width: 420px; margin: 0 auto; background: #fff; border: 2px solid #000; padding: 30px; }
        h2 { text-align: center; margin-top: 0; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 9px; box-sizing: border-box; border: 1px solid #000; }
        .btn { width: 100%; padding: 10px; border: 1px solid #000; background: #ffff00; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .link { text-align: center; margin-top: 15px; }
        .error { color: #b00000; background: #ffecec; border: 1px solid #b00000; padding: 8px; margin-bottom: 15px; }
        .success { color: #006600; background: #ecffec; border: 1px solid #006600; padding: 8px; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="box">
    <h2>Đăng nhập CineMan</h2>

    <c:if test="${not empty error}">
        <div class="error"><c:out value="${error}"/></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Tên đăng nhập</label>
            <input type="text" name="username" required autofocus />
        </div>
        <div class="form-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" required />
        </div>
        <button type="submit" class="btn">Đăng nhập</button>
    </form>

</div>
</body>
</html>
