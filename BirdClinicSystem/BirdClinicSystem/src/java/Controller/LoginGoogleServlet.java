/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CustomersDAO;
import DAO.UserDAO;
import DTO.Users;
import LoginGoogle.Constants;
import LoginGoogle.UserGoogleDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author ADMIN
 */
public class LoginGoogleServlet extends HttpServlet {

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

            String code = request.getParameter("code");
            String accessToken = getToken(code);
            UserGoogleDTO userGoogle = getUserInfo(accessToken);

            String email = userGoogle.getEmail();
            String fullName = userGoogle.getFamily_name() + " " + userGoogle.getGiven_name();
            String img = userGoogle.getPicture();

//            out.print(email + " " + fullName + " " + img);
            if (UserDAO.getUsersWithMail(email) == null) {
                UserDAO.addUserWithoutPassword(email, fullName, img, null, 0);
            }

            Users user = UserDAO.getUsersWithMail(email);
            switch (user.getRoleID()) {
                case 4:
                    CustomersDAO.addCustomer(user.getUserID());
                    session.setAttribute("customer", user);
                    session.setAttribute("name", user.getFullname());
                    session.setAttribute("UserID", user.getUserID());
                    response.sendRedirect("home");
                    break;
                case 3:
                    session.setAttribute("doctor", user);
                    session.setAttribute("docname", user.getFullname());
                    session.setAttribute("DocID", user.getUserID());
                    response.sendRedirect("doctor-profile");
                    break;
                case 2:
                    session.setAttribute("staff", user);
                    session.setAttribute("staffname", user.getFullname());
                    session.setAttribute("StaffID", user.getUserID());
                    response.sendRedirect("staff-profile");
                    break;
                case 1:
                    session.setAttribute("admin", user);
                    session.setAttribute("adminname", user.getFullname());
                    session.setAttribute("AdminID", user.getUserID());
                    response.sendRedirect("admin-homepage");
                    break;
                default:
                    response.sendRedirect("errorpage.html");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDTO getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDTO googlePojo = new Gson().fromJson(response, UserGoogleDTO.class);

        return googlePojo;
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
