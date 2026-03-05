package com.ocean.view.resort.oceanviewresortapp.model;

import java.sql.Date;

public class Reservation {
    private String reservationNumber;
    private String guestName;
    private String address;
    private String contactNumber;
    private RoomType roomType;
    private ReservationStatus status;
    private Date checkInDate;
    private Date checkOutDate;

    public Reservation() {}

    public Reservation(String reservationNumber, String guestName, String address,
                       String contactNumber, RoomType roomType, ReservationStatus status,
                       Date checkInDate, Date checkOutDate) {
        this.reservationNumber = reservationNumber;
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    // Getters & Setters
    public String getReservationNumber() { return reservationNumber; }
    public void setReservationNumber(String v) { this.reservationNumber = v; }
    public String getGuestName() { return guestName; }
    public void setGuestName(String v) { this.guestName = v; }
    public String getAddress() { return address; }
    public void setAddress(String v) { this.address = v; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String v) { this.contactNumber = v; }
    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType v) { this.roomType = v; }
    public ReservationStatus getStatus() { return status; }
    public void setStatus(ReservationStatus v) { this.status = v; }
    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date v) { this.checkInDate = v; }
    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date v) { this.checkOutDate = v; }

    // Helper methods
    public long getNumberOfNights() {
        long diff = checkOutDate.getTime() - checkInDate.getTime();
        return diff / (1000 * 60 * 60 * 24);
    }

    public double getTotalBill() {
        return getNumberOfNights() * roomType.getRatePerNight();
    }
}
