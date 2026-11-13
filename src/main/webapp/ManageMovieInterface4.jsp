<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao4.MovieDAO4, model4.Movie4, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>2. Manage Movie Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 800px; padding: 20px; margin: 0 auto; }
        .top-bar { display: flex; justify-content: flex-end; margin-bottom: 15px; gap: 15px; }
        .btn-tab { border: 1px solid #000; padding: 8px 25px; text-decoration: none; color: #000; }
        .btn-yellow { background-color: #ffff00; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 10px; }
        .btn-action { display: inline-block; padding: 4px 12px; background-color: #ffff00; border: 1px solid #000; text-decoration: none; color: #000; }
        .bottom-bar { margin-top: 25px; text-align: right; }
        .btn-back { border: 1px solid #000; padding: 6px 30px; text-decoration: none; color: #000; background: #fff; }
    </style>
</head>
<body>

<div class="container">
    <h3 style="text-align: center; margin-top: 0;">2. Manage Movie Interface 4</h3>
    
    <div class="top-bar">
        <span class="btn-tab">Danh sách phim</span>
        <a href="AddMovieInterface4.jsp" class="btn-tab btn-yellow">Thêm phim</a>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 8%;">TT</th>
                <th>Tên Phim</th>
                <th>Thể loại</th>
                <th>Thời lượng</th>
                <th style="width: 12%;">Sửa</th>
                <th style="width: 12%;">Xóa</th>
            </tr>
        </thead>
        <tbody>
            <%
                MovieDAO4 movieDAO = new MovieDAO4();
                List<Movie4> listMovie = movieDAO.getAllMovies();
                int stt = 1;
                for (Movie4 m : listMovie) {
            %>
            <tr>
                <td><%= stt++ %></td>
                <td><%= m.getMovieName() %></td>
                <td><%= m.getGenre() %></td>
                <td><%= m.getDuration() %> phút</td>
                <td><a href="#" class="btn-action">Sửa</a></td>
                <td><a href="#" class="btn-action">Xóa</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="bottom-bar">
        <a href="CinemaInterface4.jsp" class="btn-back">Quay lại</a>
    </div>
</div>

</body>
</html>