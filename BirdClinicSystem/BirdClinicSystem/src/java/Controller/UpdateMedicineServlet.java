/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MedicineCategoryDAO;
import DAO.MedicineDAO;
import DTO.Medicine;
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
public class UpdateMedicineServlet extends HttpServlet {

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
            String medid = request.getParameter("txtMedId");
            Medicine med = MedicineDAO.getMedicineByID(medid);

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
                request.setAttribute("condition", "failed");
                request.setAttribute("notify", "Update medicine failed, duplicated name!");
                request.getRequestDispatcher("Staff_MedicineList.jsp").forward(request, response);
            }
            if (medname == null || medname.trim().equals("")) {
                medname = med.getMedName();
            }
            if (medtype == null || medtype.trim().equals("")) {
                medtype = med.getMedType();
            }
            if (meddescription == null || meddescription.trim().equals("") || meddescription.trim().equalsIgnoreCase("NOTHING")) {
                if (med.getMedDescription() == null || meddescription.trim().equalsIgnoreCase("NOTHING")) {
                    meddescription = "";
                } else {
                    meddescription = med.getMedDescription();
                }
            }
            if (medprice == null || medprice.trim().equals("")) {
                medprice = String.valueOf(med.getMedPrice());
            }
            if (remainingquantity == null || remainingquantity.trim().equals("")) {
                remainingquantity = String.valueOf(med.getRemainingQuantity());
            }
            if (druguse == null || druguse.trim().equals("") || druguse.trim().equalsIgnoreCase("NOTHING")) {
                if (med.getDrugUse() == null || druguse.trim().equalsIgnoreCase("NOTHING")) {
                    druguse = "";
                } else {
                    druguse = med.getDrugUse();
                }
            }
            if (sideeffect == null || sideeffect.trim().equals("") || sideeffect.trim().equalsIgnoreCase("NOTHING")) {
                if (med.getSideEffect() == null || sideeffect.trim().equalsIgnoreCase("NOTHING")) {
                    sideeffect = "";
                } else {
                    sideeffect = med.getSideEffect();
                }
            }
            if (composition == null || composition.trim().equals("") || composition.trim().equalsIgnoreCase("NOTHING")) {
                if (med.getComposition() == null || composition.trim().equalsIgnoreCase("NOTHING")) {
                    composition = "";
                } else {
                    composition = med.getComposition();
                }
            }
            boolean result = MedicineDAO.updateMedicine(medid, medname, medtype, Float.parseFloat(medprice), Integer.parseInt(remainingquantity), meddescription, druguse, sideeffect, composition, medcategoryid);
            if (result) {
                request.setAttribute("condition", "sucess");
                request.setAttribute("notify", "Update Medicine successfully");
            } else {
                request.setAttribute("condition", "failed");
                request.setAttribute("notify", "Update Medicine failed, please try again later.");
            }

            String url = "Staff_MedicineList.jsp";
            HttpSession session = request.getSession();

            Users admin = (Users) session.getAttribute("admin");
            out.print("Haha");
            if (admin != null) {
                url = "ADB_Medicine.jsp";
            }
            request.getRequestDispatcher(url).forward(request, response);
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
