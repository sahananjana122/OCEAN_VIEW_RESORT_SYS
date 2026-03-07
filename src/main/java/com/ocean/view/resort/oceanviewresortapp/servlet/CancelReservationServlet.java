package com.ocean.view.resort.oceanviewresortapp.servlet;

import com.ocean.view.resort.oceanviewresortapp.dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cancelReservation")
public class CancelReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String resNum = req.getParameter("reservationNumber");
        ReservationDAO dao = new ReservationDAO();
        boolean success = dao.cancelReservation(resNum);

        if (success) {
            req.setAttribute("success", "Reservation " + resNum + " has been cancelled.");
        } else {
            req.setAttribute("error", "Could not cancel reservation. Please try again.");
        }

        // Reload the full list after cancel
        req.setAttribute("reservations", dao.getAllReservations());
        req.getRequestDispatcher("/allReservations.jsp").forward(req, resp);
    }
}
