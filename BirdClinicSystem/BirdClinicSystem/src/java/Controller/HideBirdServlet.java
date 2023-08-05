/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BirdDAO;
import DTO.Birds;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class HideBirdServlet extends HttpServlet {

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
            String Birdstatus = request.getParameter("BirdStatus");
            if (Birdstatus.equalsIgnoreCase("")) {
                Birdstatus = null;
            }
            String SortStatusBy = request.getParameter("SortStatusBy");
            if (SortStatusBy.equalsIgnoreCase("")) {
                SortStatusBy = null;
            }
            String keyword = request.getParameter("KeyWord");
            if (keyword.equalsIgnoreCase("")) {
                keyword = null;
            }
            request.setAttribute("birdstatus", Birdstatus);
            request.setAttribute("sortstatusby", SortStatusBy);
            request.setAttribute("keyword", keyword);
            String birdid = request.getParameter("birdId");
            Birds bird = BirdDAO.getBirdInfo(birdid);
            String act = request.getParameter("act");
            if (act.equalsIgnoreCase("hid")) {
                boolean result = BirdDAO.hideBird(birdid, 0);
                if (result) {
                    request.setAttribute("condition", "sucess");
                    request.setAttribute("notify", "Hide Bird successfully");
                } else {
                    request.setAttribute("condition", "failed");
                    request.setAttribute("notify", "Hide failed, please try again later");
                }
            } else if (act.equalsIgnoreCase("unhid")) {
                boolean result = BirdDAO.hideBird(birdid, 1);
                if (result) {
                    request.setAttribute("condition", "sucess");
                    request.setAttribute("notify", "Unhide Bird successfully");
                } else {
                    request.setAttribute("condition", "failed");
                    request.setAttribute("notify", "Unhide failed, please try again later");
                }
            }
            request.getRequestDispatcher("BirdList.jsp").forward(request, response);
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
