/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package LoginGoogle;

/**
 *
 * @author ADMIN
 */
public class Constants {

    public static String GOOGLE_CLIENT_ID = "214881563869-0r4uvnl6e104d3k4fre3imc29j0l459h.apps.googleusercontent.com";

    public static String GOOGLE_CLIENT_SECRET = "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";

    public static String GOOGLE_REDIRECT_URI = "http://localhost:3030/BirdClinicSystem/LoginGoogleServlet";

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
