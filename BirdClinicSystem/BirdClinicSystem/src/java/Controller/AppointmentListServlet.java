/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DTO.AppointmentsForm;
import DTO.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class AppointmentListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String keyword = request.getParameter("txtkeyword");
            String searchby = request.getParameter("txtsearchby");
            String pending = request.getParameter("txtpending");
            String completed = request.getParameter("txtcompleted");
            String startdate = request.getParameter("txtstartDate");
            String StartDate = null;

            if (startdate == null || startdate.equals("")) {
                StartDate = "";
            } else {
                StartDate = startdate;
            }
            String enddate = request.getParameter("txtendDate");
            String EndDate = null;
            if (enddate == null || enddate.equals("")) {
                EndDate = "";
            } else {
                EndDate = enddate;
            }
            List<AppointmentsForm> appointmentFormList = AppointmentDAO.getAllAppointmentList();
            if ((pending == null && completed == null) || (pending != null && completed != null)) {
                appointmentFormList = AppointmentDAO.getAllAppointmentList(keyword == null ? "" : keyword, searchby == null ? "appid" : searchby, "", StartDate, EndDate);
            } else if (pending != null && completed == null) {
                appointmentFormList = AppointmentDAO.getAllAppointmentList(keyword == null ? "" : keyword, searchby == null ? "appid" : searchby, pending, StartDate, EndDate);
            } else if (pending == null && completed != null) {
                appointmentFormList = AppointmentDAO.getAllAppointmentList(keyword == null ? "" : keyword, searchby == null ? "appid" : searchby, completed, StartDate, EndDate);
            }
            request.setAttribute("Pending", pending);
            request.setAttribute("Completed", completed);
            request.setAttribute("list", appointmentFormList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("searchby", searchby);
            request.setAttribute("startdate", startdate);
            request.setAttribute("enddate", enddate);
            HttpSession session = request.getSession();
            String url = "errorpage.html";
            if(session.getAttribute("staff") != null){
                url = "StaffAppointmentList.jsp";
            }else if(session.getAttribute("admin") != null){
                url = "ADB_Appointment.jsp";
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
