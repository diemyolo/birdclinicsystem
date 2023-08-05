/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DAO.BirdDAO;
import DAO.CustomersDAO;
import DAO.DoctorDAO;
import DAO.MedRecordDAO;
import DTO.Appointments;
import DTO.Birds;
import DTO.Customers;
import DTO.MedicalRecord;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class MedicalRecordServlet extends HttpServlet {

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
            String AppID = request.getParameter("appID");
            if (AppID == null) {
                AppID = (String) request.getAttribute("appID");
            }
            Appointments app = AppointmentDAO.getAppointmentByID(AppID);
            out.println("debug");
            out.println(app);
            Customers cus = MedRecordDAO.getCustomerByID(app.getCusID());

            Birds bird = BirdDAO.getBirdByID(app.getBirdID());
            String docName = DoctorDAO.getDoctorNameByID(app.getDocID());

            MedicalRecord medRecord = MedRecordDAO.getMedRecordWithAppID(AppID);
            request.setAttribute("MedRecord", medRecord);

            String noti = (String) request.getAttribute("noti");
            request.setAttribute("noti", noti);
            request.setAttribute("app", app);
            request.setAttribute("cus", cus);
            request.setAttribute("bird", bird);
            request.setAttribute("docName", docName);

            request.getRequestDispatcher("MedicalRecord.jsp").forward(request, response);

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
