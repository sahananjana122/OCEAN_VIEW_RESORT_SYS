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
  <title>Bill - Ocean View Resort</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar no-print">
  <div class="nav-brand">Ocean View Resort</div>
  <div class="nav-links">
    <a href="dashboard.jsp" class="btn btn-outline">← Dashboard</a>
    <a href="logout" class="btn btn-outline">Logout</a>
  </div>
</nav>

<div class="main-content">
  <div class="form-card search-card no-print">
    <form action="bill" method="post">
      <div class="search-row">
        <div class="form-group">
          <label>Enter Reservation Number</label>
          <input type="text" name="reservationNumber" placeholder="e.g. RES-001" required>
        </div>
        <button type="submit" class="btn btn-primary search-btn">Get Bill</button>
      </div>
    </form>
  </div>

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-error no-print"><%= request.getAttribute("error") %></div>
  <% } %>

  <% Reservation r = (Reservation) request.getAttribute("reservation");
    if (r != null) { %>
  <div class="bill-container" id="billPrint">
    <div class="bill-header">
      <h1>Ocean View Resort</h1>
      <p>Beachside Hotel, Galle, Sri Lanka</p>
      <p>Tel: +94 91 2234567 | info@oceanviewresort.com</p>
      <hr>
      <h2>INVOICE / RECEIPT</h2>
    </div>

    <div class="bill-meta">
      <div>
        <strong>Reservation No:</strong> <%= r.getReservationNumber() %><br>
        <strong>Bill Date:</strong> <%= new java.util.Date() %>
      </div>
    </div>

    <div class="bill-guest">
      <h3>Guest Information</h3>
      <table class="bill-table">
        <tr><td><strong>Name:</strong></td><td><%= r.getGuestName() %></td></tr>
        <tr><td><strong>Address:</strong></td><td><%= r.getAddress() %></td></tr>
        <tr><td><strong>Contact:</strong></td><td><%= r.getContactNumber() %></td></tr>
      </table>
    </div>

    <div class="bill-details">
      <h3>Stay Details</h3>
      <table class="bill-table full-table">
        <thead>
        <tr>
          <th>Description</th>
          <th>Check-In</th>
          <th>Check-Out</th>
          <th>Nights</th>
          <th>Rate/Night</th>
          <th>Amount</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td><%= r.getRoomType().getTypeName() %> Room</td>
          <td><%= r.getCheckInDate() %></td>
          <td><%= r.getCheckOutDate() %></td>
          <td><%= r.getNumberOfNights() %></td>
          <td><%= String.format("%.2f", r.getRoomType().getRatePerNight()) %>LKR</td>
          <td><%= String.format("%.2f", r.getTotalBill()) %>LKR</td>
        </tr>
        </tbody>
        <tfoot>
        <tr class="total-row">
          <td colspan="5"><strong>TOTAL AMOUNT</strong></td>
          <td><strong><%= String.format("%.2f", r.getTotalBill()) %>LKR</strong></td>
        </tr>
        </tfoot>
      </table>
    </div>

    <div class="bill-footer">
      <p>Thank you for staying at Ocean View Resort!</p>
      <p>We hope to see you again.</p>
    </div>
  </div>

  <div class="no-print" style="text-align:center; margin-top:20px;">
    <button onclick="window.print()" class="btn btn-primary">🖨️ Print Bill</button>
  </div>
  <% } %>
</div>
</body>
</html>