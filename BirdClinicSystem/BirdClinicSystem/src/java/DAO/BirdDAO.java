/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Birds;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class BirdDAO {

    public static ArrayList<Birds> getAllCustomerBirds(String UserID) throws Exception {
        ArrayList<Birds> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select BirdID, b.CusID as CusID, Bird_type, Bird_name, Bird_img, Age_category, Habit, Personal_note, UserID, Status from Birds b left join Customers c on b.CusID = c.CusID where UserID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, UserID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String birdid = rs.getString("BirdID");
                        String cusid = rs.getString("CusID");
                        String birdtype = rs.getString("Bird_type");
                        String birdname = rs.getString("Bird_name");
                        String birdimg = rs.getString("Bird_img");
                        String agecate = rs.getString("Age_category");
                        String habit = rs.getString("Habit");
                        String personalnote = rs.getString("Personal_note");
                        int status = rs.getInt("Status");
                        Birds bird = new Birds(birdid, birdtype, birdname, birdimg, agecate, habit, personalnote, status, cusid, UserID);
                        list.add(bird);
                    }
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

    public static ArrayList<Birds> getAllCustomerBirds(String UserID, String keyword, String Status) throws Exception {
        ArrayList<Birds> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select BirdID, b.CusID as CusID, Bird_type, Bird_name, Bird_img, Age_category, Habit, Personal_note, Status, UserID from Birds b left join Customers c on b.CusID = c.CusID where UserID = ? ";
                if (Status.equalsIgnoreCase("hidden")) {
                    sql = sql + "AND Status = 1";
                } else if (Status.equalsIgnoreCase("unhidden")) {
                    sql = sql + "AND Status = 0";
                    if (keyword.equalsIgnoreCase("asc")) {
                        sql = sql + ", Bird_name ASC";
                    } else if (keyword.equalsIgnoreCase("desc")) {
                        sql = sql + ", Bird_name DESC";
                    } else if (keyword.equalsIgnoreCase("ageasc")) {
                        sql = sql + ", CASE Age_category\n"
                                + "    WHEN 'Young' THEN 1\n"
                                + "    WHEN 'Growth' THEN 2\n"
                                + "    WHEN 'Old' THEN 3\n"
                                + "    ELSE 4\n"
                                + "	END;";
                    } else if (keyword.equalsIgnoreCase("agedesc")) {
                        sql = sql + ", CASE Age_category\n"
                                + "    WHEN 'Old' THEN 1\n"
                                + "    WHEN 'Growth' THEN 2\n"
                                + "    WHEN 'Young' THEN 3\n"
                                + "    ELSE 4\n"
                                + "	END;";
                    }
                }
                if(!Status.equalsIgnoreCase("unhidden")){
                    if (keyword.equalsIgnoreCase("asc")) {
                        sql = sql + " ORDER BY Bird_name ASC";
                    } else if (keyword.equalsIgnoreCase("desc")) {
                        sql = sql + " ORDER BY Bird_name DESC";
                    } else if (keyword.equalsIgnoreCase("ageasc")) {
                        sql = sql + " ORDER BY CASE Age_category\n"
                                + "    WHEN 'Young' THEN 1\n"
                                + "    WHEN 'Growth' THEN 2\n"
                                + "    WHEN 'Old' THEN 3\n"
                                + "    ELSE 4\n"
                                + "	END;";
                    } else if (keyword.equalsIgnoreCase("agedesc")) {
                        sql = sql + " ORDER BY CASE Age_category\n"
                                + "    WHEN 'Old' THEN 1\n"
                                + "    WHEN 'Growth' THEN 2\n"
                                + "    WHEN 'Young' THEN 3\n"
                                + "    ELSE 4\n"
                                + "	END;";
                    }
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, UserID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String birdid = rs.getString("BirdID");
                        String cusid = rs.getString("CusID");
                        String birdtype = rs.getString("Bird_type");
                        String birdname = rs.getString("Bird_name");
                        String birdimg = rs.getString("Bird_img");
                        String agecate = rs.getString("Age_category");
                        String habit = rs.getString("Habit");
                        String personalnote = rs.getString("Personal_note");
                        int status = rs.getInt("Status");
                        Birds bird = new Birds(birdid, birdtype, birdname, birdimg, agecate, habit, personalnote, status, cusid, UserID);
                        list.add(bird);
                    }
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

    public static Birds getBirdInfo(String birdID) {
        Connection cn = null;
        Birds bird = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select BirdID, CusID, Bird_name, Bird_type, Bird_img, Age_category, Habit, Personal_note, Status from Birds where BirdID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, birdID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String birdid = rs.getString("BirdID");
                    String cusid = rs.getString("CusID");
                    String birdname = rs.getString("Bird_name");
                    String birdtype = rs.getString("Bird_type");
                    String birdimg = rs.getString("Bird_img");
                    String agecate = rs.getString("Age_category");
                    String habit = rs.getString("Habit");
                    String personalnote = rs.getString("Personal_note");
                    int status = rs.getInt("Status");
                    bird = new Birds(birdid, birdtype, birdname, birdimg, agecate, habit, personalnote, status);
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
        return bird;
    }

    public static boolean updateBird(String birdID, String bird_type, String bird_name, String agecate, String habit, String personalnote) throws Exception {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Birds set Bird_type = ?, Bird_name = ?, Age_category = ?, Habit = ?, Personal_note = ? Where BirdID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, bird_type);
                pst.setString(2, bird_name);
                pst.setString(3, agecate);
                if (habit.equals("")) {
                    pst.setNull(4, Types.NULL);
                } else {
                    pst.setString(4, habit);
                }
                if (personalnote.equals("")) {
                    pst.setNull(5, Types.NULL);
                } else {
                    pst.setString(5, personalnote);
                }
                pst.setString(6, birdID);
                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
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
        return trig;
    }

    public static boolean hideBird(String birdID, int status) {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Birds set Status = ? Where BirdID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setString(2, birdID);
                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
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
        return trig;
    }

    public static boolean addBird(String userID, String birdtype, String birdname, String agecate, String habit, String personalnote) {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "insert into Birds (CusID, Bird_type, Bird_name, Age_category, Habit, Personal_note, Status) Values (?,?,?,?,?,?,?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, CustomersDAO.getCustomerID(userID));
                pst.setString(2, birdtype);
                pst.setString(3, birdname);
                pst.setString(4, agecate);
                if (habit.equals("")) {
                    pst.setNull(5, Types.NULL);
                } else {
                    pst.setString(5, habit);
                }
                if (personalnote.equals("")) {
                    pst.setNull(6, Types.NULL);
                } else {
                    pst.setString(6, personalnote);
                }
                pst.setInt(7, 1);
                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
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
        return trig;
    }
    
    //suong
    public static Birds getBirdByID(String BirdID) throws Exception{
        Birds bird = null;
        Connection cn = DBUtils.makeConnection();
        if(cn!=null){
            String sql = "SELECT BirdID, Bird_type, Bird_name, Bird_img, Age_category, Habit, Weight, Personal_note\n"
                    + "FROM Birds b\n"
                    + "WHERE b.BirdID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, BirdID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                    String Bird_type = rs.getString("Bird_type");
                    String Bird_name = rs.getString("Bird_name");
                    String Bird_img = rs.getString("Bird_img");
                    String Age_category = rs.getString("Age_category");
                    String Habit = rs.getString("Habit");
                    int Weight = rs.getInt("Weight");
                    String Personal_note = rs.getString("Personal_note");
                    bird = new Birds(BirdID, Bird_type, Bird_name, Bird_img, Age_category, Habit, Weight, Personal_note);
                }
        }
        return bird;
    }
}
