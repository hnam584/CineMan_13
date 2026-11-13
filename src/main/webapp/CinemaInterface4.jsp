<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1. Cinema Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 750px; padding: 15px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .header-btn { border: 1px solid #000; padding: 6px 15px; background: #fff; text-decoration: none; color: #000; }
        .main-layout { display: flex; border: 1px solid #000; min-height: 260px; }
        .sidebar { width: 35%; border-right: 1px solid #000; display: flex; flex-direction: column; }
        .sidebar-btn { border: none; border-bottom: 1px solid #000; padding: 15px; background: #fff; text-align: center; text-decoration: none; color: #000; font-size: 14px; }
        .sidebar-btn.active { background-color: #ffff00; font-weight: bold; }
        .content { width: 65%; display: flex; align-items: center; justify-content: center; }
    </style>
</head>
<body>

<div class="container">
    <h3 style="text-align: center; margin-top: 0;">1. Cinema Interface 4</h3>
    <div class="header">
        <span class="header-btn">Xin chào, Manager A</span>
        <a href="CinemaInterface4.jsp" class="header-btn">Đăng xuất</a>
    </div>
    
    <div class="main-layout">
        <div class="sidebar">
            <a href="#" class="sidebar-btn">Quản lí lịch chiếu</a>
            <a href="ManageMovieInterface4.jsp" class="sidebar-btn active">Quản lí phim</a>
            <a href="#" class="sidebar-btn">Quản lí phòng chiếu</a>
            <a href="#" class="sidebar-btn" style="border-bottom: none;">Thống kê</a>
        </div>
        <div class="content">
            <h3>Chào mừng đến với hệ thống Cineman</h3>
        </div>
    </div>
</div>

</body>
</html>