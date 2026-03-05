<%@ page import="com.ocean.view.resort.oceanviewresortapp.model.RoomType" %>
<%@ page import="java.util.List" %>
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
  <title>Add Reservation - Ocean View Resort</title>
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
  <h1 class="page-title">Add New Reservation</h1>

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-error"><%= request.getAttribute("error") %></div>
  <% } %>
  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success"><%= request.getAttribute("success") %></div>
  <% } %>

  <div class="form-card">
    <form action="reservation" method="post">
      <input type="hidden" name="action" value="add">

      <div class="form-row">
        <div class="form-group">
          <label>Reservation Number *</label>
          <input type="text" name="reservationNumber" placeholder="e.g. RES-001" required>
        </div>
        <div class="form-group">
          <label>Guest Name *</label>
          <input type="text" name="guestName" placeholder="Full name" required>
        </div>
      </div>

      <div class="form-group">
        <label>Address *</label>
        <textarea name="address" placeholder="Guest address" rows="2" required></textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Contact Number *</label>
          <input type="text" name="contactNumber" placeholder="e.g. +94771234567" required>
        </div>
        <div class="form-group">
          <label>Room Type *</label>
          <select name="roomTypeId" required>
            <option value="">Select Room Type</option>
            <%
              List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
              if (roomTypes != null) {
                for (RoomType rt : roomTypes) {
            %>
            <option value="<%= rt.getId() %>">
              <%= rt.getTypeName() %> ($<%= String.format("%.0f", rt.getRatePerNight()) %>/night) - <%= rt.getDescription() %>
            </option>
            <%
                }
              }
            %>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Check-In Date *</label>
          <input type="date" name="checkInDate" required>
        </div>
        <div class="form-group">
          <label>Check-Out Date *</label>
          <input type="date" name="checkOutDate" required>
        </div>
      </div>

      <div class="form-actions">
        <button type="reset" class="btn btn-outline">Clear</button>
        <button type="submit" class="btn btn-primary">Add Reservation</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
