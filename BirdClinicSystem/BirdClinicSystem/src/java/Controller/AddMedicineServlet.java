/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MedicineCategoryDAO;
import DAO.MedicineDAO;
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
public class AddMedicineServlet extends HttpServlet {

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
            String medname = request.getParameter("txtMedName");
            String medtype = request.getParameter("txtMedType");
            String medprice = request.getParameter("txtMedPrice");
            String remainingquantity = request.getParameter("txtRemainingQuantity");
            String meddescription = request.getParameter("txtMedDescription");
            String druguse = request.getParameter("txtDrugUse");
            String sideeffect = request.getParameter("txtSideEffect");
            String composition = request.getParameter("txtComposition");
            String medcategory = request.getParameter("txtMedCategory");
            String medcategoryid = MedicineCategoryDAO.getMedicineCategoryByName(medcategory).getMedCateID();
            if (MedicineDAO.checkMedNameExists(medname)) {
                request.setAttribute("WARNINGNAME", "Duplicated Medicine Name");
                request.setAttribute("MedName", medname);
                request.setAttribute("MedType", medtype);
                request.setAttribute("MedPrice", medprice);
                request.setAttribute("RemainQuantity", remainingquantity);
                request.setAttribute("MedDes", meddescription);
                request.setAttribute("DrugUse", druguse);
                request.setAttribute("SideEffect", sideeffect);
                request.setAttribute("Composition", composition);
                request.setAttribute("MedCategory", medcategory);
                request.getRequestDispatcher("Staff_AddMedicine.jsp").forward(request, response);
            } else {
                boolean result = MedicineDAO.addMedicine(medname, medtype, Float.parseFloat(medprice), Integer.parseInt(remainingquantity), meddescription, druguse, sideeffect, composition, medcategoryid);
                if (result) {

                    request.setAttribute("condition", "sucess");
                    request.setAttribute("notify", "Add Medicine successfully.");
                    request.getRequestDispatcher("Staff_AddMedicine.jsp").forward(request, response);
                } else {
                    request.setAttribute("MedName", medname);
                    request.setAttribute("MedType", medtype);
                    request.setAttribute("MedPrice", medprice);
                    request.setAttribute("RemainQuantity", remainingquantity);
                    request.setAttribute("MedDes", meddescription);
                    request.setAttribute("DrugUse", druguse);
                    request.setAttribute("SideEffect", sideeffect);
                    request.setAttribute("Composition", composition);
                    request.setAttribute("MedCategory", medcategory);
                    request.setAttribute("condition", "failed");
                    request.setAttribute("notify", "Cannot add Medicine, please try again later.");
                    request.getRequestDispatcher("Staff_AddMedicine.jsp").forward(request, response);
                }
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
