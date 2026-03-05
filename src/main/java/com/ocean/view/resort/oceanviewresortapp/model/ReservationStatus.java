package com.ocean.view.resort.oceanviewresortapp.model;

public class ReservationStatus {
    private int id;
    private String statusName;

    public ReservationStatus() {}

    public ReservationStatus(int id, String statusName) {
        this.id = id;
        this.statusName = statusName;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getStatusName() { return statusName; }
    public void setStatusName(String statusName) { this.statusName = statusName; }
}
