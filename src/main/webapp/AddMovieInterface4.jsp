<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao4.MovieDAO4, model4.Movie4" %>
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
        
        /* Modal Notify Success */
        .modal-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; }
        .modal-box { background: #fff; border: 2px solid #000; padding: 30px; text-align: center; width: 320px; box-shadow: 2px 2px 10px rgba(0,0,0,0.2); }
        .modal-msg { border: 1px solid #000; padding: 12px; margin-bottom: 20px; background: #fff; }
    </style>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    boolean isSuccess = false;
    
    // Xử lý sự kiện click nút "Thêm" theo sơ đồ Sequence/Activity
    String action = request.getParameter("subAddMovie4");
    if ("Thêm".equals(action)) {
        String name = request.getParameter("inName");
        String genre = request.getParameter("inGenre");
        String durationStr = request.getParameter("inDuration");
        String description = request.getParameter("inDescription");
        
        if (name != null && !name.trim().isEmpty()) {
            String movieId = "M" + (System.currentTimeMillis() % 100000);
            int duration = 0;
            try {
                duration = Integer.parseInt(durationStr);
            } catch (Exception e) { duration = 90; }
            
            // 1. Đóng gói thông tin bằng Model Movie4 (gọi setter)
            Movie4 movie = new Movie4();
            movie.setMovieId(movieId);
            movie.setMovieName(name);
            movie.setGenre(genre);
            movie.setDuration(duration);
            movie.setDescription(description);
            
            // 2. Gọi MovieDAO4 thực thi addMovie4(movie)
            MovieDAO4 movieDAO = new MovieDAO4();
            isSuccess = movieDAO.addMovie4(movie);
        }
    }
%>

<div class="container">
    <h3 style="text-align: center; margin-top: 0;">3. Add Movie Interface 4</h3>
    <p style="font-weight: bold; margin-bottom: 20px;">Thêm thông tin phim</p>
    
    <form action="AddMovieInterface4.jsp" method="post">
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
            <input type="submit" name="subAddMovie4" value="Thêm" class="btn btn-submit" />
            <a href="ManageMovieInterface4.jsp" class="btn btn-yellow">Quay lại</a>
        </div>
    </form>

    <%-- Popup 4. Notify Success (Hiển thị khi thêm thành công) --%>
    <% if (isSuccess) { %>
    <div class="modal-overlay">
        <div class="modal-box">
            <h4 style="margin-top: 0;">4. Notify Success</h4>
            <div class="modal-msg">Thêm phim thành công</div>
            <a href="ManageMovieInterface4.jsp" class="btn btn-yellow" style="display: inline-block;">OK</a>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>