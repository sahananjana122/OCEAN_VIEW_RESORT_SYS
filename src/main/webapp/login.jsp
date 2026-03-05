<%--
  Created by IntelliJ IDEA.
  User: sajith_h
  Date: 2/28/2026
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="login-page">
<div class="login-container">
    <div class="login-card">
<%--        <div class="resort-logo">🌊</div>--%>
        <h2>Ocean View Resort</h2>
        <p class="subtitle">Reservation Management System</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
        </form>
    </div>
</div>
</body>
</html>
