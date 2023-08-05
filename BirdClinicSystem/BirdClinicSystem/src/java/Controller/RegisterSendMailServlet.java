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
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class RegisterSendMailServlet extends HttpServlet {

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
            String code = UserDAO.md5(generateVerificationCode());
            out.print("Haha");
            Users user = (Users) request.getAttribute("newUser");
//            String email = request.getParameter("email");
//            String error = "";

            if (user == null) {
                response.sendRedirect("errorpage.html");
            }

            HttpSession session = request.getSession();
            session.setAttribute("register-code", code);

            //Session time out after 5 mins
            session.setMaxInactiveInterval(5 * 60);

            // Email details
            String fromEmail = "wearebirdclinic@gmail.com";
            String toMail = user.getEmail();
            String subject = "Verify email";

            String content = "<h1 style=\"text-align: center;\">Verify your email!</h1>"
                    + "<p style=\"text-align: center;\">Welcome to BirdClinicSystem! Please use the link below to verify your email.</p>"
                    + "<div style=\"text-align: center;\">"
                    + "<a href=\"http://localhost:3030/BirdClinicSystem/MainController?action=verifyMail&register-code="
                    + code + "&email=" + user.getEmail() + "&fullName=" + user.getFullname() + "&phone=" + user.getPhone() + "&gender=" + user.getGender() + "&address" + user.getAddress() + "&password=" + user.getPassword() + "\" style=\"display: inline-block; background-color: green; color: white; padding: 10px 20px; text-decoration: none; border-radius: 20px;\">Verify email</a>"
                    + "</div>"
                    + "<p style=\"text-align: center;\">If this was a mistake, just ignore this email and nothing will happen.</p>";

            // SMTP server configuration
            Properties properties = new Properties();
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            // Sender's credentials
            final String userMail = "wearebirdclinic@gmail.com";
            final String password = "xdchanbosucsskim";

            // Create a session with SMTP authentication
            Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(userMail, password);
                }
            });

            try {
                // Create a MimeMessage object
                MimeMessage message = new MimeMessage(mailSession);

                // Set From: header
                message.setFrom(new InternetAddress(fromEmail));

                // Set To: header
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));

                // Set Subject: header
                message.setSubject(subject);

                // Set Content: text/html
                message.setContent(content, "text/html; charset=utf-8");

                // Send the message
                Transport.send(message);

                request.getRequestDispatcher("reset-password").forward(request, response);

            } catch (MessagingException e) {
                response.getWriter().println("Failed to send email. Error: " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String generateVerificationCode() {
        // Generate a random 6-digit verification code
        int code = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(code);
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
