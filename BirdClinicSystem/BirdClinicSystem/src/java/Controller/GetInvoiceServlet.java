/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DAO.FeedbackDAO;
import DAO.InvoiceDAO;
import DAO.MedicineDAO;
import DAO.PrescriptionDAO;
import DAO.ServiceDAO;
import DTO.Feedback;
import DTO.Invoice;
import DTO.Medicine;
import DTO.PrescriptionDetail;
import DTO.Services;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class GetInvoiceServlet extends HttpServlet {

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
            String appointmentID = request.getParameter("AppID");

            Invoice invoice = InvoiceDAO.getInvoicebyAppointmentID(appointmentID);
            if (invoice == null) {
                response.sendRedirect("invoice");
            }

            String presID = invoice.getPrescriptionID();

            ArrayList<Services> serviceList = ServiceDAO.getServiceListByAppointmentID(appointmentID);
            ArrayList<PrescriptionDetail> prescriptionDetailList = PrescriptionDAO.getPrescriptionList(presID);
            HashMap<String, Medicine> medicineHashMap = new HashMap();

            for (PrescriptionDetail pd : prescriptionDetailList) {
                String medID = pd.getMedID();
                Medicine medicine = MedicineDAO.getMedicineByID(medID);

                medicineHashMap.put(medID, medicine);
            }

            String customerID = AppointmentDAO.getAppointmentByID(appointmentID).getCusID();

            Feedback feedback = FeedbackDAO.getFeedbackByAppID(appointmentID);

            request.setAttribute("invoice", invoice);
            request.setAttribute("serviceList", serviceList);
            request.setAttribute("prescriptionDetailList", prescriptionDetailList);
            request.setAttribute("medicineHashMap", medicineHashMap);
            request.setAttribute("cusID", customerID);
            if (feedback != null) {
                request.setAttribute("rate", feedback.getRating());
                request.setAttribute("description", feedback.getDescription());
            }

            request.getRequestDispatcher("invoice").forward(request, response);
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
