package com.ocean.view.resort.oceanviewresortapp.servlet;

import com.ocean.view.resort.oceanviewresortapp.dao.ReservationDAO;
import com.ocean.view.resort.oceanviewresortapp.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/allReservations")
public class AllReservationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        ReservationDAO dao = new ReservationDAO();
        List<Reservation> reservations = dao.getAllReservations();
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/allReservations.jsp").forward(req, resp);
    }
}
