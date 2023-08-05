/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.UserDAO;
import DTO.Users;

/**
 *
 * @author ASUS
 */
public class ChangeProfileDoctorServlet extends HttpServlet {

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
            HttpSession session = request.getSession(true);
            Users doctor = (Users) session.getAttribute("doctor");
            String keepemail = doctor.getEmail();
            String fullname = request.getParameter("txtFullName");
            String gender = request.getParameter("txtGender");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String birthdate = request.getParameter("txtBirthDate");
            boolean success = true;
            if (fullname == null || fullname.trim().equals("")) {
                fullname = doctor.getFullname();
            }
            if (gender == null || gender.trim().equals("")) {
                gender = doctor.getGender();
            }
            if (phone == null || phone.trim().equals("")) {
                phone = doctor.getPhone();
            }
            else if (!UserDAO.isPhoneRightFormat(phone) || UserDAO.getUsersWithPhone(phone) != null) {
                success = false;
            }
            if (address == null || address.trim().equals("")) {
                address = doctor.getAddress();
            }
            if (birthdate == null || birthdate.trim().equals("")) {
                birthdate = doctor.getBirthDate();
                out.print(doctor);
            }

            boolean result = false;
            if(success)
            {
                result = UserDAO.updateUser(keepemail, fullname, gender, phone, address, birthdate);
            }
            if (result) {
                Users newDoc = (Users) UserDAO.getUsersWithMail(keepemail);
                session.setAttribute("doctor", newDoc);
                request.setAttribute("condition", "sucess");
                request.setAttribute("notify", "Change Successfully.");
            } else {
                session.setAttribute("doctor", doctor);
                request.setAttribute("condition", "failed");
                request.setAttribute("notify", "Change unsuccessful, please try again.");
            }
            request.getRequestDispatcher("DoctorProfile.jsp").forward(request, response);

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
