/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Customers;
import DTO.MedicalRecord;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class MedRecordDAO {

    public static int addMedRecord(String birdID, String appID, String symptoms, String diagnosis, String treatment) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "INSERT INTO Medical_Record (BirdID, AppID, Symptoms, Diagnosis, Treatment)\n"
                    + "VALUES (?, ?, ?, ? ,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, birdID);
            pst.setString(2, appID);
            pst.setString(3, symptoms);
            pst.setString(4, diagnosis);
            pst.setString(5, treatment);
            result = pst.executeUpdate();
        }
        return result;
    }

    public static int updateMedRecord(String medRecordID, String symptoms, String Diagnosis, String treatment) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "UPDATE Medical_Record\n"
                    + "SET Symptoms = ?, Diagnosis = ?, Treatment = ?\n"
                    + "WHERE MedRecordID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, symptoms);
            pst.setString(2, Diagnosis);
            pst.setString(3, treatment);
            pst.setString(4, medRecordID);
            result = pst.executeUpdate();
        }

        return result;
    }

    public static MedicalRecord getMedRecordWithAppID(String AppID) throws Exception {
        MedicalRecord result = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT m.MedRecordID, m.BirdID, m.AppID, m.Symptoms, m.Diagnosis, m.Treatment\n"
                    + "FROM Medical_Record m \n"
                    + "WHERE m.AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, AppID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String MedRecordID = rs.getString("MedRecordID");
                String BirdID = rs.getString("BirdID");
                String Symptoms = rs.getString("Symptoms");
                String Diagnosis = rs.getString("Diagnosis");
                String treatment = rs.getString("treatment");
                result = new MedicalRecord(MedRecordID, BirdID, AppID, Symptoms, Diagnosis, treatment);
            }
        }

        return result;
    }

    public static Customers getCustomerByID(String CusID) throws Exception {
        Customers cus = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT c.CusID, c.UserID, u.Email, u.Password, u.Fullname, u.Phone\n"
                    + "FROM Customers c left join Users u ON c.UserID = u.UserID\n"
                    + "WHERE c.CusID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, CusID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
//                    String CusID = rs.getString("CusID");
                String Email = rs.getString("Email");
                String Password = rs.getString("Password");
                String Fullname = rs.getString("Fullname");
                String Phone = rs.getString("Phone");
                cus = new Customers(CusID, Email, Password, Fullname, Phone);
            }
        }
        cn.close();
        return cus;
    }

    public static ArrayList<MedicalRecord> getMedicalRecordByBirdID(String birdID) throws Exception {
        ArrayList<MedicalRecord> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT m.MedRecordID, m.BirdID, m.AppID, m.Symptoms, m.Diagnosis, m.Treatment\n"
                    + "FROM Medical_Record m\n"
                    + "WHERE m.BirdID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, birdID);
            ResultSet rs = pst.executeQuery();
            if(rs != null){
                while(rs.next()){
                    String medRecordID = rs.getString("MedRecordID");
                    String BirdID = rs.getString("BirdID");
                    String appID = rs.getString("AppID");
                    String symptoms = rs.getString("Symptoms");
                    String Diagnosis = rs.getString("Diagnosis");
                    String treatment = rs.getString("Treatment");
                    MedicalRecord medRecord = new MedicalRecord(medRecordID, BirdID, appID, symptoms, Diagnosis, treatment);
                    list.add(medRecord);
                }
            }
        }
        return list;

    }

    public static void main(String[] args) throws Exception {
        System.out.println(MedRecordDAO.getCustomerByID("CUS-0002").getCusID());
        System.out.println("hihi");
    }
}
