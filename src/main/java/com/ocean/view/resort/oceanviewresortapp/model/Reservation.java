package com.ocean.view.resort.oceanviewresortapp.model;

import java.sql.Date;

public class Reservation {
    private String reservationNumber;
    private String guestName;
    private String address;
    private String contactNumber;
    private String roomType;
    private Date checkInDate;
    private Date checkOutDate;
    private String status; // Add this field

    public Reservation() {}

    public Reservation(String reservationNumber, String guestName, String address,
                       String contactNumber, String roomType, Date checkInDate,
                       Date checkOutDate, String status) {
        this.reservationNumber = reservationNumber;
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
    }

    // Getters and Setters
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getReservationNumber() { return reservationNumber; }
    public void setReservationNumber(String reservationNumber) { this.reservationNumber = reservationNumber; }
    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }
    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }

    // Helper: calculate number of nights
    public long getNumberOfNights() {
        long diff = checkOutDate.getTime() - checkInDate.getTime();
        return diff / (1000 * 60 * 60 * 24);
    }

    // Helper: get room rate per night
    public double getRoomRate() {
        switch (roomType.toLowerCase()) {
            case "deluxe": return 100.0;
            case "suite":  return 200.0;
            default:       return 50.0; // standard
        }
    }

    // Helper: calculate total bill
    public double getTotalBill() {
        return getNumberOfNights() * getRoomRate();
    }
}
