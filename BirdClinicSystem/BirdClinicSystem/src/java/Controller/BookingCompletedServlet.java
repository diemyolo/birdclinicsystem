/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.UserDAO;
import DTO.Doctor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class BookingCompletedServlet extends HttpServlet {

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
            int slot = Integer.parseInt(request.getParameter("slot"));
            int date = Integer.parseInt(request.getParameter("date"));
            int month = Integer.parseInt(request.getParameter("month"));
            int year = Integer.parseInt(request.getParameter("year"));
            String services = request.getParameter("services");
            request.setAttribute("slot", slot);
            request.setAttribute("date", date);
            request.setAttribute("month", month);
            request.setAttribute("year", year);
            request.setAttribute("services", services);

            //customer detail
            String name = request.getParameter("name");
            String birdName = request.getParameter("birdName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            request.setAttribute("name", name);
            request.setAttribute("birdName", birdName);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.setAttribute("note", note);
            
            HttpSession session = request.getSession(true);
            String BirdID = AppointmentDAO.getBirdID(birdName);

            String UserID = (String) (session.getAttribute("UserID"));
            String CusID = UserDAO.getCusID(UserID);
            

            //find doctor
            ArrayList<Doctor> listDoctor = DoctorDAO.getAvailableDoctorIDList(slot, date, month, year);
            String DocID = null;
            for(Doctor x : listDoctor){
                DocID = x.getDocID();
            }
            
            String docName = DoctorDAO.getDoctorNameByID(DocID);
            
            request.setAttribute("doctor", docName);           
            int result = 1;
            if(!AppointmentDAO.checkSlotIfBooked(slot, date, month, year, CusID)){
                result = AppointmentDAO.addNewAppointment(CusID, DocID, BirdID, year + "-" + (month+1) + "-" + date, slot, 1, services, note);
            }
            
            if (result == 1) {
                request.getRequestDispatcher("booking-completed").forward(request, response);
            } else {
                response.sendRedirect("errorpage.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
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
