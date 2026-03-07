package com.ocean.view.resort.oceanviewresortapp.servlet;

import com.ocean.view.resort.oceanviewresortapp.dao.ReservationDAO;
import com.ocean.view.resort.oceanviewresortapp.dao.RoomTypeDAO;
import com.ocean.view.resort.oceanviewresortapp.model.Reservation;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check session
        if (req.getSession().getAttribute("loggedUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        ReservationDAO dao = new ReservationDAO();

        if ("add".equals(action)) {
            String resNum = req.getParameter("reservationNumber");

            if (dao.reservationExists(resNum)) {
                req.setAttribute("error", "Reservation number already exists!");
                loadRoomTypes(req);
                req.getRequestDispatcher("/addReservation.jsp").forward(req, resp);
                return;
            }

            int roomTypeId = Integer.parseInt(req.getParameter("roomTypeId"));

            Reservation r = new Reservation();
            r.setReservationNumber(resNum);
            r.setGuestName(req.getParameter("guestName"));
            r.setAddress(req.getParameter("address"));
            r.setContactNumber(req.getParameter("contactNumber"));
            r.setCheckInDate(Date.valueOf(req.getParameter("checkInDate")));
            r.setCheckOutDate(Date.valueOf(req.getParameter("checkOutDate")));

            boolean success = dao.addReservation(r, roomTypeId);
            if (success) {
                req.setAttribute("success", "Reservation added successfully!");
            } else {
                req.setAttribute("error", "Failed to add reservation. Please try again.");
            }
            loadRoomTypes(req);
            req.getRequestDispatcher("/addReservation.jsp").forward(req, resp);

        } else if ("view".equals(action)) {
            String resNum = req.getParameter("reservationNumber");
            Reservation r = dao.getReservation(resNum);
            if (r != null) {
                req.setAttribute("reservation", r);
            } else {
                req.setAttribute("error", "Reservation not found.");
            }
            req.getRequestDispatcher("/viewReservation.jsp").forward(req, resp);
        }
    }

    private void loadRoomTypes(HttpServletRequest req) {
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        req.setAttribute("roomTypes", roomTypeDAO.getAllRoomTypes());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("view".equals(action)) {
            // Coming from "View" button with reservationNumber in URL
            String resNum = req.getParameter("reservationNumber");
            ReservationDAO dao = new ReservationDAO();
            Reservation r = dao.getReservation(resNum);
            if (r != null) {
                req.setAttribute("reservation", r);
            } else {
                req.setAttribute("error", "Reservation not found.");
            }
            req.getRequestDispatcher("/viewReservation.jsp").forward(req, resp);

        } else {
            // Default: load add reservation form with room types
            loadRoomTypes(req);
            req.getRequestDispatcher("/addReservation.jsp").forward(req, resp);
        }
    }
}
