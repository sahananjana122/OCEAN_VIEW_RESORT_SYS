package com.ocean.view.resort.oceanviewresortapp.servlet;

import com.ocean.view.resort.oceanviewresortapp.dao.ReservationDAO;
import com.ocean.view.resort.oceanviewresortapp.model.Reservation;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String resNum = req.getParameter("reservationNumber");
        ReservationDAO dao = new ReservationDAO();
        Reservation r = dao.getReservation(resNum);

        if (r != null) {
            req.setAttribute("reservation", r);
        } else {
            req.setAttribute("error", "Reservation not found.");
        }
        req.getRequestDispatcher("/bill.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}
