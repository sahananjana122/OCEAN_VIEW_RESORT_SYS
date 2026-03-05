<%--
  Created by IntelliJ IDEA.
  User: sajith_h
  Date: 2/28/2026
  Time: 1:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ocean.view.resort.oceanviewresortapp.model.Reservation" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar">
    <div class="nav-brand">🌊 Ocean View Resort</div>
    <div class="nav-links">
        <a href="dashboard.jsp" class="btn btn-outline">← Dashboard</a>
        <a href="logout" class="btn btn-outline">Logout</a>
    </div>
</nav>

<div class="main-content">
    <h1 class="page-title">View Reservation</h1>

    <div class="form-card search-card">
        <form action="reservation" method="post">
            <input type="hidden" name="action" value="view">
            <div class="search-row">
                <div class="form-group">
                    <label>Enter Reservation Number</label>
                    <input type="text" name="reservationNumber" placeholder="e.g. RES-001" required>
                </div>
                <button type="submit" class="btn btn-primary search-btn">Search</button>
            </div>
        </form>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <% Reservation r = (Reservation) request.getAttribute("reservation");
        if (r != null) { %>
    <div class="detail-card">
        <div class="detail-header">
            <h2>Reservation Details</h2>
            <span class="res-badge"><%= r.getReservationNumber() %></span>
        </div>
        <div class="detail-grid">
            <div class="detail-item">
                <span class="detail-label">Guest Name</span>
                <span class="detail-value"><%= r.getGuestName() %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Contact Number</span>
                <span class="detail-value"><%= r.getContactNumber() %></span>
            </div>
            <div class="detail-item full-width">
                <span class="detail-label">Address</span>
                <span class="detail-value"><%= r.getAddress() %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Room Type</span>
                <span class="detail-value room-badge <%= r.getRoomType().getTypeName() %>"><%= r.getRoomType().getTypeName() %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Number of Nights</span>
                <span class="detail-value"><%= r.getNumberOfNights() %> nights</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Check-In Date</span>
                <span class="detail-value"><%= r.getCheckInDate() %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Check-Out Date</span>
                <span class="detail-value"><%= r.getCheckOutDate() %></span>
            </div>
        </div>
        <div class="detail-footer">
            <a href="bill?action=view&reservationNumber=<%= r.getReservationNumber() %>" class="btn btn-primary">Generate Bill</a>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>
