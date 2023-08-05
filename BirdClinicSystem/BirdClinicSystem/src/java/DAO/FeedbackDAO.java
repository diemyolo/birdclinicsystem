/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Feedback;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class FeedbackDAO {

    public static ArrayList<Feedback> getAllFeedback() {
        Connection cn = null;
        ArrayList<Feedback> list = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select FedID, AppID, CusID, Rating, Description from Feedback";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    String fedID = rs.getString("FedID");
                    String appID = rs.getString("AppID");
                    String cusID = rs.getString("CusID");
                    int rating = rs.getInt("Rating");
                    String description = rs.getString("Description");

                    Feedback invoice = new Feedback(fedID, appID, cusID, rating, description);
                    list.add(invoice);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static boolean addFeedback(String appID, String cusID, int rating, String description) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "insert into Feedback(AppID, CusID, Rating, Description)\n"
                        + "values (?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, appID);
                pst.setString(2, cusID);
                pst.setInt(3, rating);
                pst.setString(4, description);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }

    public static boolean updateFeedback(String appID, int rating, String description) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "update Feedback\n"
                        + "set Rating = ?, Description = ?\n"
                        + "where AppID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, rating);
                pst.setString(2, description);
                pst.setString(3, appID);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }

    public static Feedback getFeedbackByAppID(String appID) {
        Feedback feedback = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select FedID, AppID, CusID, Rating, Description from Feedback\n"
                        + "where AppID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, appID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String fedID = rs.getString("FedID");
                    String cusID = rs.getString("CusID");
                    int rating = rs.getInt("Rating");
                    String description = rs.getString("Description");

                    feedback = new Feedback(fedID, appID, cusID, rating, description);
                }

            }

        } catch (Exception e) {

        }

        return feedback;
    }
}
