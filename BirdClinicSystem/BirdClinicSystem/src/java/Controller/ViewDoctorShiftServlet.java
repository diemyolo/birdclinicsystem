/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DoctorDAO;
import DAO.DoctorShiftDAO;
import DAO.ShiftDAO;
import DTO.DoctorShift;
import DTO.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class ViewDoctorShiftServlet extends HttpServlet {

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
            String doctorID = request.getParameter("doctorID");
            String doctorName = DoctorDAO.getDoctorNameByID(doctorID);
            
            List<Shift> shiftList = ShiftDAO.getAllShift();

            List<DoctorShift> availableDoctorShiftList = DoctorShiftDAO.getAllAvaiableDoctorShift();

            HashMap<String, DoctorShift> availableDoctorShiftHashMap = new HashMap<>();

            for (Shift shift : shiftList) {
                String shiftID = shift.getShiftID();
                DoctorShift doctorShift = DoctorShiftDAO.getAvailableDoctorShift(doctorID, shiftID);

                if (doctorShift != null) {
                    availableDoctorShiftHashMap.put(shiftID, doctorShift);
                }
            }

            request.setAttribute("doctorName", doctorName);
            request.setAttribute("shiftList", shiftList);
            request.setAttribute("doctorID", doctorID);
            request.setAttribute("doctorShiftHashMap", availableDoctorShiftHashMap);
            request.getRequestDispatcher("ADB_ViewDoctorShift.jsp").forward(request, response);
        }
        catch(Exception e)
        {
            
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
