
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar">
    <div class="nav-brand">Ocean View Resort</div>
    <div class="nav-links">
        <span>Welcome, <%= session.getAttribute("loggedUser") %></span>
        <a href="logout" class="btn btn-outline">Logout</a>
    </div>
</nav>

<div class="main-content">
    <h1 class="page-title">Dashboard</h1>
    <p class="page-subtitle">Select an option to manage reservations</p>

    <div class="dashboard-grid">
        <a href="reservation" class="dashboard-card">
            <div class="card-icon">📋</div>
            <h3>Add Reservation</h3>
            <p>Register a new guest booking</p>
        </a>
        <a href="viewReservation.jsp" class="dashboard-card">
            <div class="card-icon">🔍</div>
            <h3>View Reservation</h3>
            <p>Look up existing booking details</p>
        </a>
        <a href="bill.jsp" class="dashboard-card">
            <div class="card-icon">💰</div>
            <h3>Generate Bill</h3>
            <p>Calculate and print guest bill</p>
        </a>
        <a href="allReservations" class="dashboard-card">
            <div class="card-icon">📊</div>
            <h3>All Reservations</h3>
            <p>View and manage all guest bookings</p>
        </a>
        <a href="help.jsp" class="dashboard-card">
            <div class="card-icon">❓</div>
            <h3>Help</h3>
            <p>System usage guidelines</p>
        </a>
    </div>
</div>
</body>
</html>
