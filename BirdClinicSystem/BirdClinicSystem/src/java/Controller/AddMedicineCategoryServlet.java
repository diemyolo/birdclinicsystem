/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MedicineCategoryDAO;
import DTO.Staffs;
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
public class AddMedicineCategoryServlet extends HttpServlet {

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
            String url = "Staff_AddMedicine.jsp";
            HttpSession session = request.getSession();
            Users admin = (Users) session.getAttribute("admin");
            if(admin != null){
                url = "error.html";
            }
            String medcatename = request.getParameter("txtMedicineCateName");
            
            if(MedicineCategoryDAO.checkMedCateNameExist(medcatename)){
                request.setAttribute("MedCateName", medcatename);
                request.setAttribute("WARNINGCATEGORY", "Medicine Category Name already exist!!!");
                request.setAttribute("anchorTrigger", "anchorLink");
                request.getRequestDispatcher(url).forward(request, response);
            }else{
                boolean result = MedicineCategoryDAO.addMedicineCategory(medcatename);
                if(result){
                    request.setAttribute("MedCategory", medcatename);
                    request.setAttribute("condition", "sucess");
                    request.setAttribute("notify", "Successfully added Medicine Category");
                }else{
                    request.setAttribute("MedCategory", medcatename);
                    request.setAttribute("condition", "failed");
                    request.setAttribute("notify", "Cannot add Category, please try again later.");
                }
                request.setAttribute("anchorTrigger", null);
                request.getRequestDispatcher(url).forward(request, response);
            }
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
