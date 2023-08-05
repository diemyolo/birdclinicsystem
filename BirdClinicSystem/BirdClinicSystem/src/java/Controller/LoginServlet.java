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
import java.util.HashSet;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        boolean isValid = false;
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String remember = request.getParameter("remember");
        try {
            Users user = UserDAO.getUsers(username, password);
            if (!UserDAO.isMailRightFormat(username) && !UserDAO.isPhoneRightFormat(username)) {
                session.setAttribute("WARNING", "Mail or phone is not valid format");
            } else if (user == null) {
                request.setAttribute("WARNING", "Incorrect email/phone or password");
            } //invalid user
            else {
                isValid = true;
            }
            // dimyolo fix nhe
            if (isValid) {
                switch (user.getRoleID()) {
                    case 4:
                        session.setAttribute("customer", user);
                        session.setAttribute("name", user.getFullname());
                        session.setAttribute("UserID", user.getUserID());
                        Cookie u = new Cookie("Username", username);
                        Cookie v = new Cookie("Password", password);
                        Cookie r = new Cookie("Remember", remember);
                        u.setMaxAge(60 * 60 * 24);
                        if (remember != null) {
                            v.setMaxAge(60 * 60 * 24);
                            r.setMaxAge(60 * 60 * 24);
                        } else {
                            v.setMaxAge(0);
                            r.setMaxAge(0);
                        }
                        response.addCookie(u);
                        response.addCookie(v);
                        response.addCookie(r);
                        response.sendRedirect("home");
                        break;
                    case 3:
                        session.setAttribute("doctor", user);
                        session.setAttribute("docname", user.getFullname());
                        session.setAttribute("DocID", user.getUserID());
                        Cookie c = new Cookie("Username", username);
                        Cookie d = new Cookie("Password", password);
                        Cookie g = new Cookie("Remember", remember);
                        c.setMaxAge(60 * 60 * 24);
                        if (remember != null) {
                            d.setMaxAge(60 * 60 * 24);
                            g.setMaxAge(60 * 60 * 24);
                        } else {
                            d.setMaxAge(0);
                            g.setMaxAge(0);
                        }
                        response.addCookie(c);
                        response.addCookie(d);
                        response.addCookie(g);
                        response.sendRedirect("doctor-profile");
                        break;
                    case 2:
                        session.setAttribute("staff", user);
                        session.setAttribute("staffname", user.getFullname());
                        session.setAttribute("StaffID", user.getUserID());
                        Cookie a = new Cookie("Username", username);
                        Cookie b = new Cookie("Password", password);
                        Cookie h = new Cookie("Remember", remember);
                        a.setMaxAge(60 * 60 * 24);
                        if (remember != null) {
                            b.setMaxAge(60 * 60 * 24);
                            h.setMaxAge(60 * 60 * 24);
                        } else {
                            b.setMaxAge(0);
                            h.setMaxAge(0);
                        }
                        response.addCookie(a);
                        response.addCookie(b);
                        response.addCookie(h);
                        response.sendRedirect("staff-profile");
                        break;
                    case 1:
                        session.setAttribute("admin", user);
                        session.setAttribute("adminname", user.getFullname());
                        session.setAttribute("AdminID", user.getUserID());
                        Cookie e = new Cookie("Username", username);
                        Cookie f = new Cookie("Password", password);
                        Cookie i = new Cookie("Remember", remember);
                        e.setMaxAge(60 * 60 * 24);
                        if (remember != null) {
                            f.setMaxAge(60 * 60 * 24);
                            i.setMaxAge(60 * 60 * 24);
                        } else {
                            f.setMaxAge(0);
                            i.setMaxAge(0);
                        }
                        response.addCookie(e);
                        response.addCookie(f);
                        response.addCookie(i);
                        response.sendRedirect("MainController?action=InvoiceList");
                        break;
                    default:
                        break;
                }
            } else {
                request.setAttribute("txtUsername", username);
                request.setAttribute("txtPassword", password);
                request.getRequestDispatcher("login").forward(request, response);
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
        request.getRequestDispatcher("login").forward(request, response);
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
