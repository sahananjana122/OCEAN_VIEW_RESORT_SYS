
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
  <title>Help - Ocean View Resort</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar">
  <div class="nav-brand">Ocean View Resort</div>
  <div class="nav-links">
    <a href="dashboard.jsp" class="btn btn-outline">← Dashboard</a>
    <a href="logout" class="btn btn-outline">Logout</a>
  </div>
</nav>

<div class="main-content">
  <h1 class="page-title">Help & User Guide</h1>

  <div class="help-container">
    <div class="help-section">
      <h3>🔐 1. Login</h3>
      <p>Enter your assigned username and password on the login page. Contact your system administrator if you have trouble logging in. Default credentials are <strong>admin / admin123</strong>.</p>
    </div>
    <div class="help-section">
      <h3>📋 2. Add New Reservation</h3>
      <p>Click <strong>"Add Reservation"</strong> from the dashboard. Fill in all required fields — the Reservation Number must be unique (e.g., RES-001). Choose check-out date after check-in date. Select the appropriate room type based on guest preference.</p>
    </div>
    <div class="help-section">
      <h3>🔍 3. View Reservation Details</h3>
      <p>Click <strong>"View Reservation"</strong> and enter the guest's reservation number. All booking details will be displayed including guest info, room type, and stay duration.</p>
    </div>
    <div class="help-section">
      <h3>💰 4. Generate Bill</h3>
      <p>Click <strong>"Generate Bill"</strong> and enter the reservation number. The system calculates the total based on room rate × number of nights. Use the Print button to print a physical copy for the guest.</p>
      <table class="help-table">
        <tr><th>Room Type</th><th>Rate Per Night</th></tr>
        <tr><td>Standard</td><td>$50.00</td></tr>
        <tr><td>Deluxe</td><td>$100.00</td></tr>
        <tr><td>Suite</td><td>$200.00</td></tr>
      </table>
    </div>
    <div class="help-section">
      <h3>🚪 5. Logout</h3>
      <p>Always click the <strong>Logout</strong> button when you are done to secure the system. Do not leave the system unattended while logged in.</p>
    </div>
  </div>
</div>
</body>
</html>
