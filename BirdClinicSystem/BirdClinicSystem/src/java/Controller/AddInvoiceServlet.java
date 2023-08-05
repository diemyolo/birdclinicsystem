/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DAO.InvoiceDAO;
import DAO.ServiceDAO;
import DTO.Appointments;
import DTO.Services;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class AddInvoiceServlet extends HttpServlet {

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
            String appID = request.getParameter("AppID");
            String presID = request.getParameter("PresID");
            float totalPresMoney = Float.parseFloat(request.getParameter("TotalPresMoney"));
            
            float totalServiceMoney = 0;
            
            String doctorID = request.getParameter("DocID");
            
            out.print(appID);
            out.print(presID);
            out.print(totalPresMoney);
            out.print(doctorID);
            
            ArrayList<Services> serviceList = ServiceDAO.getServiceListByAppointmentID(appID);
            
            for(Services s: serviceList)
            {
                totalServiceMoney += s.getPrice();
            }
            
            float totalMoney = totalPresMoney + totalServiceMoney;
            float tax = 0.1f;
            
            totalMoney += totalMoney*tax;
            
            if(InvoiceDAO.getInvoicebyAppointmentID(appID) == null)
            {
                out.print("add");
                InvoiceDAO.addInvoice(appID, presID, totalMoney, 0);
            }
            else
            {
                out.print("update");
                InvoiceDAO.updateInvoice(appID, totalMoney, 0);
            }
            Appointments app = AppointmentDAO.getAppointmentByID(appID);
            request.setAttribute("appID", appID);
            request.setAttribute("docID", doctorID);
            request.setAttribute("app", app);
            request.getRequestDispatcher("prescription").forward(request, response);
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
