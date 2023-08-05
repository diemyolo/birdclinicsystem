/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BirdDAO;
import DTO.Birds;
import DTO.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class AddBirdServlet extends HttpServlet {

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

            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("customer");
            String userid = user.getUserID();
            out.print(userid);

            String birdname = request.getParameter("txtBirdName");
            String birdtype = request.getParameter("txtBirdSpecies");
            String birdage = request.getParameter("txtBirdAge");
            String birdhabit = request.getParameter("txtBirdHabit");
            String birdnote = request.getParameter("txtBirdNote");

            if (birdname == null || birdname.trim().equals("") || birdtype == null || birdtype.trim().equals("")) {
                if (birdname == null || birdname.trim().equals("")) {
                    request.setAttribute("WARNINGNAME", "Invalid Bird Name");
                    request.setAttribute("birdtype", birdtype);
                    request.setAttribute("birdage", birdage);
                    request.setAttribute("birdhabit", birdhabit);
                    request.setAttribute("birdnote", birdnote);
                }
                if (birdtype == null || birdtype.trim().equals("")) {
                    request.setAttribute("WARNINGTYPE", "Invalid Bird Species");
                    request.setAttribute("birdname", birdname);
                    request.setAttribute("birdage", birdage);
                    request.setAttribute("birdhabit", birdhabit);
                    request.setAttribute("birdnote", birdnote);
                }
                request.setAttribute("anchorTrigger", "anchorLink");
            } else {
                boolean result = BirdDAO.addBird(userid, birdtype, birdname, birdage, birdhabit, birdnote);
                if (result) {
                    request.setAttribute("anchorTrigger", null);
                    request.setAttribute("condition", "sucess");
                    request.setAttribute("notify", "Add Bird successfully.");
                } else {
                    request.setAttribute("anchorTrigger", null);
                    request.setAttribute("condition", "failed");
                    request.setAttribute("notify", "Cannot add Bird, please try again later.");
                }
            }
            request.getRequestDispatcher("bird-list").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("errorpage.html");
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
