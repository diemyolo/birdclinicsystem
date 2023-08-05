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
public class UpdateBirdServlet extends HttpServlet {

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
            String birdID = request.getParameter("birdId");
            Birds bird = BirdDAO.getBirdInfo(birdID);

            String birdname = request.getParameter("txtBirdName");
            String birdtype = request.getParameter("txtBirdSpecies");
            String birdage = request.getParameter("txtBirdAge");
            String birdhabit = request.getParameter("txtBirdHabit");
            String birdnote = request.getParameter("txtBirdNote");

            if (birdname == null || birdname.trim().equals("")) {
                birdname = bird.getBird_name();
            }
            if (birdtype == null || birdtype.trim().equals("")) {
                birdtype = bird.getBird_type();
            }
            if (birdage == null || birdage.trim().equals("")) {
                birdage = bird.getAge_cate();
            }
            if (birdhabit == null || birdhabit.trim().equals("") || birdhabit.trim().equalsIgnoreCase("NOTHING")) {
                if (bird.getHabit() == null || birdhabit.trim().equalsIgnoreCase("NOTHING")) {
                    birdhabit = "";
                } else {
                    birdhabit = bird.getHabit();
                }
            }
            if (birdnote == null || birdnote.trim().equals("") || birdnote.trim().equalsIgnoreCase("NOTHING")) {
                if (bird.getPersonal_note() == null || birdnote.trim().equalsIgnoreCase("NOTHING")) {
                    birdnote = "";
                } else {
                    birdnote = bird.getPersonal_note();
                }

            }
//            out.print(birdname + birdtype + birdage + birdhabit + birdnote + birdID);
            boolean result = BirdDAO.updateBird(birdID, birdtype, birdname, birdage, birdhabit, birdnote);
            if (result) {
                request.setAttribute("condition", "sucess");
                request.setAttribute("notify", "Update Bird successfully");
                Birds newbird = BirdDAO.getBirdInfo(birdID);
                request.setAttribute("bird", newbird);
            } else {
                request.setAttribute("condition", "failed");
                request.setAttribute("notify", "Update Bird failed, please try again later.");
                request.setAttribute("bird", bird);
            }
            request.getRequestDispatcher("BirdList.jsp").forward(request, response);
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
