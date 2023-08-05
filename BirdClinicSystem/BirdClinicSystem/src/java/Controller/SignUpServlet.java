/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DoctorDAO;
import DAO.StaffsDAO;
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
public class SignUpServlet extends HttpServlet {

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
            String fullName = request.getParameter("txtFullname");
            String phoneNumber = request.getParameter("txtPhoneNumber");
            String gender = request.getParameter("txtGender");
            String address = request.getParameter("txtAddress");
            String password = request.getParameter("txtPassword");
            String confirmPassword = request.getParameter("txtConfirm");

            String roleID = request.getParameter("roleID");

            // Validation
            boolean isValid = true;

            //Email validation
            if (email == null || email.isEmpty()) {
                isValid = false;
                request.setAttribute("emailError", "Email is required");
            } else if (!UserDAO.isMailRightFormat(email)) {
                isValid = false;
                request.setAttribute("emailError", "Wrong email format");
            } else if (UserDAO.getUsersWithMail(email) != null) {
                isValid = false;
                request.setAttribute("emailError", "Email existed");
            }

            //Full name validation
            if (fullName == null || fullName.isEmpty()) {
                isValid = false;
                request.setAttribute("fullnameError","Full name is required");
            }

            // Phone number validation
            if (phoneNumber == null || phoneNumber.isEmpty()) {
                isValid = false;
                request.setAttribute("phoneError", "Phone Number is required");
            } else if (!UserDAO.isPhoneRightFormat(phoneNumber)) {
                isValid = false;
                request.setAttribute("phoneError", "Wrong phone number format");
            } else if (UserDAO.getUsersWithPhone(phoneNumber) != null) {
                isValid = false;
                request.setAttribute("phoneError", "Phone existed");
            }

            // Password validation
            if (password == null || password.isEmpty()) {
                isValid = false;
                request.setAttribute("passwordError", "Password is required");
            } else if (!UserDAO.isPasswordLengthValidated(password)) {
                isValid = false;
                request.setAttribute("passwordError", "Password must be at least 10 characters");
            }

            //Confirm password validation
            if (confirmPassword == null || confirmPassword.isEmpty()) {
                isValid = false;
                request.setAttribute("confirmError", "Confirm password is required");
            } else if (!password.equals(confirmPassword)) {
                isValid = false;
                request.setAttribute("confirmError", "Confirm password is different from password");
            }

            if (isValid) {
                if (roleID != null) {
                    int role = Integer.parseInt(roleID);

                    Users newUser = new Users();
                    newUser.setEmail(email);
                    newUser.setPassword(password);
                    newUser.setFullname(fullName);
                    newUser.setGender(gender);
                    newUser.setAddress(address);
                    newUser.setPhone(phoneNumber);
                    newUser.setStatus(0);
                    newUser.setRoleID(role);

                    UserDAO.addUser(newUser);

                    Users employee = UserDAO.getUsersWithMail(email);

                    switch (role) {
                        case 2:
                            StaffsDAO.addStaff(employee);
                            request.getRequestDispatcher("MainController?action=StaffList").forward(request, response);
                            break;
                        case 3:
                            DoctorDAO.addDoctor(employee);
                            request.getRequestDispatcher("MainController?action=DoctorList").forward(request, response);
                            break;
                    }

                    
                } else {
                    try {
                        //add to database
                        Users newUser = new Users();
                        newUser.setEmail(email);
                        newUser.setPassword(password);
                        newUser.setFullname(fullName);
                        newUser.setGender(gender);
                        newUser.setAddress(address);
                        newUser.setPhone(phoneNumber);
                        newUser.setStatus(1);
                        newUser.setRoleID(4);

                        request.setAttribute("newUser", newUser);
//                    UserDAO.addUser(email, password, fullName, phoneNumber);
                        request.getRequestDispatcher("MainController?action=registerSendMail").forward(request, response);
//                    response.sendRedirect("Login.jsp");
                    } catch (Exception e) {

                    }
                }

            } else {
                request.setAttribute("email", email);
                request.setAttribute("fullname", fullName);
                request.setAttribute("gender", gender);
                request.setAttribute("address", address);
                request.setAttribute("phone", phoneNumber);
                request.setAttribute("password", password);
                request.setAttribute("confirm", confirmPassword);

                if (roleID == null) {
                    request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                } else if (roleID.equals("2")) {
                    request.getRequestDispatcher("ADB_AddStaff.jsp").forward(request, response);
                } else if (roleID.equals("3")) {
                    request.getRequestDispatcher("ADB_AddDoctor.jsp").forward(request, response);
                }
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
