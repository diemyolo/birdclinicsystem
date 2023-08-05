/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.UserDAO;
import DTO.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class ChangePasswordServlet extends HttpServlet {

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
            String email = request.getParameter("txtEmail");
            String currentPassword = request.getParameter("txtCurrentPassword");
            String newPassword = request.getParameter("txtNewPassword");
            String confirmPassword = request.getParameter("txtConfirm");

            boolean isValid = false;
            String error = "";

            Users user = UserDAO.getUsersWithMail(email);

            if (user.getPassword() == null) {
                if (newPassword == null || newPassword.isEmpty()) {
                    error = "New password is required";
                } else if (!UserDAO.isPasswordLengthValidated(newPassword)) {
                    error = "New password must be at least 10 characters";
                } //Check valid confirm password 
                else if (confirmPassword == null || confirmPassword.isEmpty()) {
                    error = "Confirm password is empty";
                } else if (!newPassword.equals(confirmPassword)) {
                    error = "Confirm password must be the same as new password";
                } else {
                    isValid = true;
                }
            } 
            else {
                if (currentPassword == null || currentPassword.isEmpty()) {
                    error = "Current password is required";
                } else if (UserDAO.getUsers(email, currentPassword) == null) {
                    error = "Wrong password";
                } //Check valid new password
                else if (newPassword == null || newPassword.isEmpty()) {
                    error = "New password is required";
                } else if (!UserDAO.isPasswordLengthValidated(newPassword)) {
                    error = "New password must be at least 10 characters";
                } //Check valid confirm password 
                else if (confirmPassword == null || confirmPassword.isEmpty()) {
                    error = "Confirm password is empty";
                } else if (!newPassword.equals(confirmPassword)) {
                    error = "Confirm password must be the same as new password";
                } else {
                    isValid = true;
                }
            }

            //Execute
            if (isValid) {
                UserDAO.updateUserPassword(email, newPassword);
                switch(user.getRoleID())
                {
                    case 1:
                        response.sendRedirect("admin-profile");
                        break;
                    case 2:
                        response.sendRedirect("staff-profile");
                        break;
                    case 3:
                        response.sendRedirect("doctor-profile");
                        break;
                    case 4:
                        response.sendRedirect("user-profile");
                        break; 
                }
                
                
            } else {
                request.setAttribute("error", error);
                request.setAttribute("txtCurrentPassword", currentPassword);
                request.setAttribute("txtNewPassword", newPassword);
                request.setAttribute("txtConfirm", confirmPassword);

                request.getRequestDispatcher("change-password").forward(request, response);
            }
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
