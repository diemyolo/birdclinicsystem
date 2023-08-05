/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Medicine;
import DTO.Prescription;
import DTO.PrescriptionDetail;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class PrescriptionDAO {

    public static ArrayList<Medicine> getPDByPresID(String PresID) throws Exception {
        ArrayList<Medicine> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT pd.PresDetailID, m.MedID, m.MedName, m.MedDescription, m.MedPrice, pd.Quantity, pd.Usage\n"
                    + "	FROM PrescriptionDetail pd LEFT JOIN Prescription p ON pd.PresID = p.PresID LEFT JOIN Medicine m ON pd.MedID = m.MedID\n"
                    + "	WHERE pd.PresID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, PresID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String PD = rs.getString("PresDetailID");
                    String medID = rs.getString("MedID");
                    String medName = rs.getString("MedName");
                    String medDes = rs.getString("MedDescription");
                    float medPrice = rs.getFloat("MedPrice");
                    int quantity = rs.getInt("Quantity");
                    String usage = rs.getString("usage");
                    Medicine med = new Medicine(PD, medID, medName, medPrice, quantity, medDes, usage);
                    list.add(med);
                }
            }
        }
        return list;
    }

    public static int addNewPresDetail(String presID, String medID, int quantity, String usage) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "INSERT INTO PrescriptionDetail (PresID, MedID, Quantity, Usage)\n"
                    + "	VALUES(?, ?, ?, ?);";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, presID);
            pst.setString(2, medID);
            pst.setInt(3, quantity);
            pst.setString(4, usage);
            if (pst.executeUpdate() == 1) {
                sql = "Update Medicine \n"
                        + "Set RemainingQuantity = RemainingQuantity - ? \n"
                        + "Where MedID = ?";
                pst = cn.prepareStatement(sql);
                pst.setInt(1, quantity);
                pst.setString(2, medID);
                result = pst.executeUpdate();
            }
        }

        return result;
    }

    public static int deletePD(String PD, int quantity, String medID) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "DELETE FROM PrescriptionDetail\n"
                    + "	WHERE PresDetailID = ?;";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, PD);
            if (pst.executeUpdate() == 1) {
                sql = "Update Medicine \n"
                        + "Set RemainingQuantity = RemainingQuantity + ? \n"
                        + "Where MedID = ?";
                pst = cn.prepareStatement(sql);
                pst.setInt(1, quantity);
                pst.setString(2, medID);
                result = pst.executeUpdate();
            }
        }

        return result;
    }

    public static Prescription checkPresExist(String appID) throws Exception {
        Prescription result = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT p.PresID, p.DocID, p.Usage, p.MedRecordID, a.AppointDate\n"
                    + "	FROM Prescription p LEFT JOIN Medical_Record m on p.MedRecordID = m.MedRecordID LEFT JOIN Appointments a on m.AppID = a.AppID\n"
                    + "	WHERE a.AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, appID);
            ResultSet rs = pst.executeQuery();
            if (rs != null & rs.next()) {
                String presID = rs.getString("PresID");
                String docID = rs.getString("DocID");
                String usage = rs.getString("Usage");
                String medRecordID = rs.getString("MedRecordID");
                String date = rs.getString("AppointDate");
                result = new Prescription(presID, docID, usage, medRecordID, date);
            }
        }

        return result;
    }

    public static Prescription getPresByMedRecordID(String medRecordID) throws Exception {
        Prescription result = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT p.PresID, p.DocID, p.Usage, p.MedRecordID, a.AppointDate\n"
                    + "	FROM Prescription p LEFT JOIN Medical_Record m on p.MedRecordID = m.MedRecordID LEFT JOIN Appointments a on m.AppID = a.AppID\n"
                    + "	WHERE p.MedRecordID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, medRecordID);
            ResultSet rs = pst.executeQuery();
            if (rs != null & rs.next()) {
                String presID = rs.getString("PresID");
                String docID = rs.getString("DocID");
                String usage = rs.getString("Usage");
                String date = rs.getString("AppointDate");
                result = new Prescription(presID, docID, usage, medRecordID, date);
            }
        }

        return result;
    }

    public static int addNewPres(String docID, String usage, String medRecordID) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "INSERT INTO Prescription (DocID, Usage, MedRecordID)\n"
                    + "	VALUES (?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docID);
            pst.setString(2, usage);
            pst.setString(3, medRecordID);
            result = pst.executeUpdate();
        }
        return result;
    }

    public static int updatePres(String presID, String usage) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "UPDATE Prescription\n"
                    + "	SET Usage = ?\n"
                    + "	WHERE PresID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, usage);
            pst.setString(2, presID);
            result = pst.executeUpdate();
        }

        return result;
    }

    public static ArrayList<PrescriptionDetail> getPrescriptionList(String presID) throws Exception {
        ArrayList<PrescriptionDetail> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select PresDetailID, PresID, MedID, Quantity from PrescriptionDetail\n"
                    + "where PresID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, presID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String presDetailID = rs.getString("PresDetailID");
                    String medID = rs.getString("MedID");
                    int quantity = rs.getInt("Quantity");

                    PrescriptionDetail prescriptionDetail = new PrescriptionDetail(presDetailID, presID, medID, quantity);
                    list.add(prescriptionDetail);
                }
            }
        }
        return list;
    }

    public static boolean checkPDExist(String presID) throws Exception {
        boolean result = false;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT PresDetailID\n"
                    + "FROM PrescriptionDetail \n"
                    + "WHERE PresID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, presID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = true;
            }
        }

        return result;
    }
}
