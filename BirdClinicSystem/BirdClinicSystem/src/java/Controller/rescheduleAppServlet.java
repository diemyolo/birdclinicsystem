/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.AppointmentDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;

/**
 *
 * @author ASUS
 */
public class rescheduleAppServlet extends HttpServlet {

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
            String name = request.getParameter("name");
            String birdName = request.getParameter("birdName");
            String services = request.getParameter("services");
            String doctor = request.getParameter("doctor");

            String resDate = request.getParameter("resDate");
            int resSlot = Integer.parseInt(request.getParameter("resSlot"));

            LocalDate parsedDate = LocalDate.parse(resDate);
            int resDay = parsedDate.getDayOfMonth();
            int resMonth = parsedDate.getMonthValue();
            int resYear = parsedDate.getYear();

            request.setAttribute("slot", resSlot);
            request.setAttribute("date", resDay);
            request.setAttribute("month", resMonth - 1);
            request.setAttribute("year", resYear);
            request.setAttribute("services", services);
            request.setAttribute("name", name);
            request.setAttribute("birdName", birdName);
            request.setAttribute("doctor", doctor);

            request.setAttribute("notify", "Reschedule successfully!");
            request.setAttribute("condition", "sucess");

            HttpSession session = request.getSession(true);
            String UserID = (String) (session.getAttribute("UserID"));
            String CusID = UserDAO.getCusID(UserID);

            String appID = AppointmentDAO.getAppID(date, month, year, CusID, slot);

            int result = AppointmentDAO.rescheduleApp(appID, resDate, resSlot);
            if(request.getParameter("fromApp")==null){
                request.getRequestDispatcher("booking-completed?slot=" + resSlot).forward(request, response);
            }
            else{
                request.getRequestDispatcher("MainController?action=CustomerAppointmentList").forward(request, response);
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
