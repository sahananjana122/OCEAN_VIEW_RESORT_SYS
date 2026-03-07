
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ocean.view.resort.oceanviewresortapp.model.Reservation, java.util.List" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Reservations - Ocean View Resort</title>
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
    <h1 class="page-title">All Reservations</h1>
    <p class="page-subtitle">Overview of all guest bookings</p>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Search/filter bar -->
    <div class="table-toolbar">
        <input type="text" id="searchInput" placeholder="🔍  Search by name or reservation number..."
               onkeyup="filterTable()" class="search-input">
        <span class="record-count">
            Total: <strong><%= reservations != null ? reservations.size() : 0 %></strong> reservations
        </span>
    </div>

    <div class="table-card">
        <% if (reservations == null || reservations.isEmpty()) { %>
        <div class="empty-state">
            <div style="font-size:48px;">📭</div>
            <h3>No reservations found</h3>
            <p>Add a new reservation to get started.</p>
            <a href="addReservation.jsp" class="btn btn-primary" style="margin-top:12px;">Add Reservation</a>
        </div>
        <% } else { %>
        <table class="res-table" id="reservationTable">
            <thead>
            <tr>
                <th>Res. No.</th>
                <th>Guest Name</th>
                <th>Contact</th>
                <th>Room Type</th>
                <th>Check-In</th>
                <th>Check-Out</th>
                <th>Nights</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Reservation r : reservations) { %>
            <tr>
                <td><strong><%= r.getReservationNumber() %></strong></td>
                <td><%= r.getGuestName() %></td>
                <td><%= r.getContactNumber() %></td>
                <td>
                        <span class="room-badge <%= r.getRoomType().getTypeName() %>">
                            <%= r.getRoomType().getTypeName() %>
                        </span>
                </td>
                <td><%= r.getCheckInDate() %></td>
                <td><%= r.getCheckOutDate() %></td>
                <td><%= r.getNumberOfNights() %></td>
                <td>
                        <span class="status-badge <%= r.getStatus().getStatusName() %>">
                            <%= r.getStatus().getStatusName() %>
                        </span>
                </td>
                <td class="action-cell">
                    <a href="reservation?action=view&reservationNumber=<%= r.getReservationNumber() %>"
                       class="action-btn view-btn" title="View Details">👁 View</a>

                    <a href="bill?action=view&reservationNumber=<%= r.getReservationNumber() %>"
                       class="action-btn bill-btn" title="Generate Bill">💰 Bill</a>

                    <% if ("Active".equals(r.getStatus().getStatusName())) { %>
                    <button class="action-btn cancel-btn"
                            onclick="confirmCancel('<%= r.getReservationNumber() %>', '<%= r.getGuestName() %>')"
                            title="Cancel Reservation">✖ Cancel</button>
                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

<!-- Cancel Confirmation Modal -->
<div id="cancelModal" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div style="font-size:40px; text-align:center;">⚠️</div>
        <h3>Cancel Reservation?</h3>
        <p id="modalMessage">Are you sure you want to cancel this reservation?</p>
        <div class="modal-actions">
            <button onclick="closeModal()" class="btn btn-outline-dark">No, Keep It</button>
            <form id="cancelForm" action="cancelReservation" method="post" style="display:inline;">
                <input type="hidden" name="reservationNumber" id="cancelResNum">
                <button type="submit" class="btn btn-danger">Yes, Cancel It</button>
            </form>
        </div>
    </div>
</div>

<script>
    function confirmCancel(resNum, guestName) {
        document.getElementById('modalMessage').textContent =
            'Cancel reservation ' + resNum + ' for ' + guestName + '? This cannot be undone.';
        document.getElementById('cancelResNum').value = resNum;
        document.getElementById('cancelModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('cancelModal').style.display = 'none';
    }

    function filterTable() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#reservationTable tbody tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(input) ? '' : 'none';
        });
    }
</script>
</body>
</html>
