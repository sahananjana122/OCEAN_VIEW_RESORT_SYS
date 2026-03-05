package com.ocean.view.resort.oceanviewresortapp.dao;

import com.ocean.view.resort.oceanviewresortapp.model.RoomType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT * FROM room_types";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RoomType(
                        rs.getInt("id"),
                        rs.getString("type_name"),
                        rs.getDouble("rate_per_night"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public RoomType getRoomTypeById(int id) {
        String sql = "SELECT * FROM room_types WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new RoomType(
                        rs.getInt("id"),
                        rs.getString("type_name"),
                        rs.getDouble("rate_per_night"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
