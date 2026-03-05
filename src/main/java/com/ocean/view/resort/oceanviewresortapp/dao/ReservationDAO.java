package com.ocean.view.resort.oceanviewresortapp.dao;

import com.ocean.view.resort.oceanviewresortapp.model.Reservation;
import com.ocean.view.resort.oceanviewresortapp.model.ReservationStatus;
import com.ocean.view.resort.oceanviewresortapp.model.RoomType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // Maps a ResultSet row to a Reservation object (with JOIN data)
    private Reservation mapRow(ResultSet rs) throws SQLException {
        RoomType roomType = new RoomType(
                rs.getInt("rt.id"),
                rs.getString("rt.type_name"),
                rs.getDouble("rt.rate_per_night"),
                rs.getString("rt.description")
        );
        ReservationStatus status = new ReservationStatus(
                rs.getInt("rs.id"),
                rs.getString("rs.status_name")
        );
        return new Reservation(
                rs.getString("r.reservation_number"),
                rs.getString("r.guest_name"),
                rs.getString("r.address"),
                rs.getString("r.contact_number"),
                roomType,
                status,
                rs.getDate("r.check_in_date"),
                rs.getDate("r.check_out_date")
        );
    }

    private static final String BASE_QUERY =
            "SELECT r.*, rt.id AS `rt.id`, rt.type_name AS `rt.type_name`, " +
                    "rt.rate_per_night AS `rt.rate_per_night`, rt.description AS `rt.description`, " +
                    "rs.id AS `rs.id`, rs.status_name AS `rs.status_name` " +
                    "FROM reservations r " +
                    "JOIN room_types rt ON r.room_type_id = rt.id " +
                    "JOIN reservation_status rs ON r.status_id = rs.id ";

    public boolean addReservation(Reservation r, int roomTypeId) {
        // status_id = 1 (Active) for all new reservations
        String sql = "INSERT INTO reservations (reservation_number, guest_name, address, " +
                "contact_number, room_type_id, status_id, check_in_date, check_out_date) " +
                "VALUES (?,?,?,?,?,1,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getReservationNumber());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContactNumber());
            ps.setInt(5, roomTypeId);
            ps.setDate(6, r.getCheckInDate());
            ps.setDate(7, r.getCheckOutDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reservation getReservation(String reservationNumber) {
        String sql = BASE_QUERY + "WHERE r.reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reservationNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = BASE_QUERY + "ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean cancelReservation(String reservationNumber) {
        // status_id = 2 (Cancelled)
        String sql = "UPDATE reservations SET status_id = 2 WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reservationNumber);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean reservationExists(String reservationNumber) {
        String sql = "SELECT 1 FROM reservations WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reservationNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
