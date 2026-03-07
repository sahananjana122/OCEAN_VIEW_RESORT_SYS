<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ocean.view.resort.oceanviewresortapp.model.RoomType, java.util.List" %>
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
  <div class="nav-brand">Ocean View Resort</div>
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
    <form id="reservationForm" action="reservation" method="post" onsubmit="return validateForm()">
      <input type="hidden" name="action" value="add">

      <div class="form-row">
        <div class="form-group">
          <label>Reservation Number *</label>
          <input type="text" id="reservationNumber" name="reservationNumber"
                 placeholder="e.g. 1001" maxlength="10">
          <span class="field-error" id="err-resNum"></span>
        </div>
        <div class="form-group">
          <label>Guest Name *</label>
          <input type="text" id="guestName" name="guestName"
                 placeholder="Full name" maxlength="100">
          <span class="field-error" id="err-guestName"></span>
        </div>
      </div>

      <div class="form-group">
        <label>Address *</label>
        <textarea id="address" name="address"
                  placeholder="Guest address" rows="2" maxlength="255"></textarea>
        <span class="field-error" id="err-address"></span>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Contact Number *</label>
          <input type="text" id="contactNumber" name="contactNumber"
                 placeholder="e.g. 0771234567" maxlength="10">
          <span class="field-error" id="err-contact"></span>
        </div>
        <div class="form-group">
          <label>Room Type *</label>
          <select id="roomTypeId" name="roomTypeId">
            <option value="">Select Room Type</option>
            <%
              List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
              if (roomTypes != null) {
                for (RoomType rt : roomTypes) {
            %>
            <option value="<%= rt.getId() %>">
              <%= rt.getTypeName() %> (<%= String.format("%.0f", rt.getRatePerNight()) %>/night) - <%= rt.getDescription() %>
            </option>
            <%
                }
              }
            %>
          </select>
          <span class="field-error" id="err-roomType"></span>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Check-In Date *</label>
          <input type="date" id="checkInDate" name="checkInDate">
          <span class="field-error" id="err-checkIn"></span>
        </div>
        <div class="form-group">
          <label>Check-Out Date *</label>
          <input type="date" id="checkOutDate" name="checkOutDate">
          <span class="field-error" id="err-checkOut"></span>
        </div>
      </div>

      <div class="form-actions">
        <button type="button" onclick="resetForm()" class="btn btn-outline-dark">Clear</button>
        <button type="submit" class="btn btn-primary">Add Reservation</button>
      </div>
    </form>
  </div>
</div>

<script>
  // Set today as minimum date for check-in
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('checkInDate').setAttribute('min', today);
  document.getElementById('checkOutDate').setAttribute('min', today);

  // Update checkout min date when checkin changes
  document.getElementById('checkInDate').addEventListener('change', function () {
    const checkIn = this.value;
    document.getElementById('checkOutDate').setAttribute('min', checkIn);
    // Reset checkout if it's before new check-in
    const checkOut = document.getElementById('checkOutDate').value;
    if (checkOut && checkOut <= checkIn) {
      document.getElementById('checkOutDate').value = '';
      showError('err-checkOut', 'Check-out must be after check-in date.');
    } else {
      clearError('err-checkOut');
    }
  });

  // Live validation on each field
  document.getElementById('reservationNumber').addEventListener('input', function () {
    validateReservationNumber(true);
  });
  document.getElementById('guestName').addEventListener('input', function () {
    validateGuestName(true);
  });
  document.getElementById('address').addEventListener('input', function () {
    validateAddress(true);
  });
  document.getElementById('contactNumber').addEventListener('input', function () {
    validateContact(true);
  });
  document.getElementById('roomTypeId').addEventListener('change', function () {
    validateRoomType(true);
  });
  document.getElementById('checkInDate').addEventListener('change', function () {
    validateCheckIn(true);
  });
  document.getElementById('checkOutDate').addEventListener('change', function () {
    validateCheckOut(true);
  });

  // ===== INDIVIDUAL VALIDATORS =====

  function validateReservationNumber(live) {
    const val = document.getElementById('reservationNumber').value.trim();
    if (val === '') {
      return showError('err-resNum', 'Reservation number is required.');
    }
    if (!/^\d+$/.test(val)) {
      return showError('err-resNum', 'Reservation number must contain digits only.');
    }
    if (val.length > 10) {
      return showError('err-resNum', 'Reservation number must be 10 digits or fewer.');
    }
    clearError('err-resNum');
    return true;
  }

  function validateGuestName(live) {
    const val = document.getElementById('guestName').value.trim();
    if (val === '') {
      return showError('err-guestName', 'Guest name is required.');
    }
    if (val.length < 3) {
      return showError('err-guestName', 'Name must be at least 3 characters.');
    }
    if (!/^[a-zA-Z\s.'-]+$/.test(val)) {
      return showError('err-guestName', 'Name can only contain letters, spaces, hyphens, and apostrophes.');
    }
    clearError('err-guestName');
    return true;
  }

  function validateAddress(live) {
    const val = document.getElementById('address').value.trim();
    if (val === '') {
      return showError('err-address', 'Address is required.');
    }
    if (val.length < 5) {
      return showError('err-address', 'Please enter a valid address (at least 5 characters).');
    }
    clearError('err-address');
    return true;
  }

  function validateContact(live) {
    const val = document.getElementById('contactNumber').value.trim();
    if (val === '') {
      return showError('err-contact', 'Contact number is required.');
    }
    if (!/^\d{10}$/.test(val)) {
      return showError('err-contact', 'Contact number must be exactly 10 digits.');
    }
    clearError('err-contact');
    return true;
  }

  function validateRoomType(live) {
    const val = document.getElementById('roomTypeId').value;
    if (val === '') {
      return showError('err-roomType', 'Please select a room type.');
    }
    clearError('err-roomType');
    return true;
  }

  function validateCheckIn(live) {
    const val = document.getElementById('checkInDate').value;
    if (val === '') {
      return showError('err-checkIn', 'Check-in date is required.');
    }
    if (val < today) {
      return showError('err-checkIn', 'Check-in date cannot be in the past.');
    }
    clearError('err-checkIn');
    return true;
  }

  function validateCheckOut(live) {
    const checkIn = document.getElementById('checkInDate').value;
    const val = document.getElementById('checkOutDate').value;
    if (val === '') {
      return showError('err-checkOut', 'Check-out date is required.');
    }
    if (checkIn && val <= checkIn) {
      return showError('err-checkOut', 'Check-out must be at least 1 day after check-in.');
    }
    clearError('err-checkOut');
    return true;
  }

  // ===== MAIN FORM VALIDATOR =====

  function validateForm() {
    const v1 = validateReservationNumber(false);
    const v2 = validateGuestName(false);
    const v3 = validateAddress(false);
    const v4 = validateContact(false);
    const v5 = validateRoomType(false);
    const v6 = validateCheckIn(false);
    const v7 = validateCheckOut(false);

    if (!v1 || !v2 || !v3 || !v4 || !v5 || !v6 || !v7) {
      // Scroll to first error
      const firstError = document.querySelector('.field-error:not(:empty)');
      if (firstError) {
        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
      return false;
    }
    return true;
  }

  // ===== HELPERS =====

  function showError(id, message) {
    const el = document.getElementById(id);
    el.textContent = message;
    el.style.display = 'block';
    // Highlight the input
    const input = el.previousElementSibling;
    if (input) input.classList.add('input-error');
    return false;
  }

  function clearError(id) {
    const el = document.getElementById(id);
    el.textContent = '';
    el.style.display = 'none';
    const input = el.previousElementSibling;
    if (input) input.classList.remove('input-error');
  }

  function resetForm() {
    document.getElementById('reservationForm').reset();
    // Clear all error messages
    document.querySelectorAll('.field-error').forEach(el => {
      el.textContent = '';
      el.style.display = 'none';
    });
    document.querySelectorAll('.input-error').forEach(el => {
      el.classList.remove('input-error');
    });
  }
</script>
</body>
</html>