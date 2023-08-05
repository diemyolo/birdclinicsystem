/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.DoctorShift;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class DoctorShiftDAO {
    public static ArrayList<DoctorShift> getAllAvaiableDoctorShift()
    {
        Connection cn = null;
        ArrayList<DoctorShift> list = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select DocID, ShiftID, Status from DoctorShift where status = 1";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    String docID = rs.getString("DocID");
                    String shiftID = rs.getString("ShiftID");
                    int status = rs.getInt("Status");

                    DoctorShift doctorShift = new DoctorShift(docID, shiftID, status);
                    list.add(doctorShift);
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
    
    public static DoctorShift getAvailableDoctorShift(String doctorID, String shiftID)
    {
        Connection cn = null;
        DoctorShift doctorShift = null;
        
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select DocID, ShiftID, Status from DoctorShift where status = 1 and ShiftID = ? and DocID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, shiftID);
                pst.setString(2, doctorID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int status = rs.getInt("Status");

                    doctorShift = new DoctorShift(doctorID, shiftID, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return doctorShift;
    }
    
    public static DoctorShift getDoctorShift(String doctorID, String shiftID)
    {
        Connection cn = null;
        DoctorShift doctorShift = null;
        
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select DocID, ShiftID, Status from DoctorShift where ShiftID = ? and DocID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, shiftID);
                pst.setString(2, doctorID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int status = rs.getInt("Status");

                    doctorShift = new DoctorShift(doctorID, shiftID, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return doctorShift;
    }
    
    public static boolean updateDoctorShiftStatus(String shiftID, int status)
    {
        boolean success = false;
        Connection cn = null;
        int kq = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "update DoctorShift set Status = ? where ShiftID = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setString(2, shiftID);

                kq = pst.executeUpdate();
                success = true;
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
        return success;
    }
    
    public static boolean addDoctorShift(String doctorID, String shiftID)
    {
        boolean success = false;
        Connection cn = null;
        int kq = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "insert into DoctorShift(DocID, ShiftID, Status) values (?, ?, 1)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, doctorID);
                pst.setString(2, shiftID);

                kq = pst.executeUpdate();
                success = true;
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
        return success;
    }
}
