/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Medicine;
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
public class MedicineDAO {
    
    public static ArrayList<Medicine> getAllMedicine(){
        ArrayList<Medicine> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedID, MedName, MedPrice, MedDescription, MedType, RemainingQuantity, DrugUse, SideEffect, Composition, MedCategoryID from Medicine";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String medid = rs.getString("MedID");
                        String medname = rs.getString("MedName");
                        float medprice = rs.getFloat("MedPrice");
                        String meddescription = rs.getString("MedDescription");
                        String medtype = rs.getString("MedType");
                        int remainingquantity = rs.getInt("RemainingQuantity");
                        String druguse = rs.getString("DrugUse");
                        String sideeffect = rs.getString("SideEffect");
                        String composition = rs.getString("Composition");
                        String medcateid = rs.getString("MedCategoryID");
                        Medicine med = new Medicine(medid, medname, medprice, meddescription, medtype, remainingquantity, druguse, sideeffect, composition, medcateid);
                        list.add(med);
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
    
    public static ArrayList<Medicine> getAllMedicine(String keyword, String medcatename){
        ArrayList<Medicine> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedID, MedName, MedPrice, MedDescription, MedType, RemainingQuantity, DrugUse, SideEffect, Composition, Medicine.MedCategoryID, MedCategoryName from Medicine join MedicineCategory on Medicine.MedCategoryID = MedicineCategory.MedCategoryID where MedName like ?";
                if(medcatename.equalsIgnoreCase("All")){
                    sql = sql + " and MedCategoryName like ?";
                }else{
                    sql = sql + " and MedCategoryName = ?";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                if(medcatename.equalsIgnoreCase("All")){
                    pst.setString(2, "%%");
                }else{
                    pst.setString(2, medcatename);
                }
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String medid = rs.getString("MedID");
                        String medname = rs.getString("MedName");
                        float medprice = rs.getFloat("MedPrice");
                        String meddescription = rs.getString("MedDescription");
                        String medtype = rs.getString("MedType");
                        int remainingquantity = rs.getInt("RemainingQuantity");
                        String druguse = rs.getString("DrugUse");
                        String sideeffect = rs.getString("SideEffect");
                        String composition = rs.getString("Composition");
                        String medcateid = rs.getString("MedCategoryID");
                        Medicine med = new Medicine(medid, medname, medprice, meddescription, medtype, remainingquantity, druguse, sideeffect, composition, medcateid);
                        list.add(med);
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
    
    public static ArrayList<String> getMedicineType(){
        ArrayList<String> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select distinct MedType from Medicine";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String medtype = rs.getString("MedType");
                        list.add(medtype);
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
    
    public static Medicine getMedicineByID(String MedID){
        Medicine med = new Medicine();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedID, MedName, MedPrice, MedDescription, MedType, RemainingQuantity, DrugUse, SideEffect, Composition, MedCategoryID from Medicine where MedID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, MedID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String medid = rs.getString("MedID");
                        String medname = rs.getString("MedName");
                        float medprice = rs.getFloat("MedPrice");
                        String meddescription = rs.getString("MedDescription");
                        String medtype = rs.getString("MedType");
                        int remainingquantity = rs.getInt("RemainingQuantity");
                        String druguse = rs.getString("DrugUse");
                        String sideeffect = rs.getString("SideEffect");
                        String composition = rs.getString("Composition");
                        String medcateid = rs.getString("MedCategoryID");
                        med = new Medicine(medid, medname, medprice, meddescription, medtype, remainingquantity, druguse, sideeffect, composition, medcateid);
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
        return med;
    }
    
    public static boolean updateMedicine(String medid, String medname, String medtype, float medprice, int remainingquantity, String meddescription, String druguse, String sideeffect, String composition, String medcateid){
        Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "update Medicine set MedName = ?, MedPrice = ?, MedDescription = ?, MedType = ?, RemainingQuantity = ?, DrugUse = ?, SideEffect = ?, Composition = ?, MedCategoryID = ? where MedID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medname);
                pst.setFloat(2, medprice);
                if (meddescription.equals("")) {
                    pst.setNull(3, Types.NULL);
                } else {
                    pst.setString(3, meddescription);
                }
                pst.setString(4, medtype);
                pst.setFloat(5, remainingquantity);
                if (druguse.equals("")) {
                    pst.setNull(6, Types.NULL);
                } else {
                    pst.setString(6, druguse);
                }
                if (sideeffect.equals("")) {
                    pst.setNull(7, Types.NULL);
                } else {
                    pst.setString(7, sideeffect);
                }
                if (composition.equals("")) {
                    pst.setNull(8, Types.NULL);
                } else {
                    pst.setString(8, composition);
                }
                pst.setString(9, medcateid);
                pst.setString(10, medid);
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
    
    public static boolean checkMedNameExists(String medname){
        boolean result = true;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if(cn != null){
                String sql = "Select MedName from Medicine where MedName = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medname);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    result = true;
                }else{
                    result = false;
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
        return result;
    }
    
    public static boolean addMedicine(String medname, String medtype, float medprice, int remainingquantity, String meddescription, String druguse, String sideeffect, String composition, String medcateid){
        boolean result = false;
        Connection cn = null;
        int kq = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "insert into Medicine (MedName, MedPrice, MedType, RemainingQuantity, MedDescription, DrugUse, SideEffect, Composition, MedCategoryID) Values (?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medname);
                pst.setString(3, medtype);
                pst.setFloat(2, medprice);
                pst.setInt(4, remainingquantity);
                if (meddescription.equals("")) {
                    pst.setNull(5, Types.NULL);
                } else {
                    pst.setString(5, meddescription);
                }
                if (druguse.equals("")) {
                    pst.setNull(6, Types.NULL);
                } else {
                    pst.setString(6, druguse);
                }
                if (sideeffect.equals("")) {
                    pst.setNull(7, Types.NULL);
                } else {
                    pst.setString(7, sideeffect);
                }
                if (composition.equals("")) {
                    pst.setNull(8, Types.NULL);
                } else {
                    pst.setString(8, composition);
                }
                pst.setString(9, medcateid);
                kq = pst.executeUpdate();
                if (kq == 1) {
                    result = true;
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
        return result;
    }
    
    public static ArrayList<Medicine> searchMedByKeyWordToAdd(String keyword, String PresID) throws Exception{
        ArrayList<Medicine> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if(cn!=null){
            String sql = "SELECT m.MedID, m.MedName, m.MedPrice, m.MedDescription, m.RemainingQuantity\n"
                    + "FROM Medicine m\n"
                    + "WHERE m.MedName LIKE ?\n"
                    + "AND m.MedID NOT IN (\n"
                    + "    SELECT MedID\n"
                    + "    FROM PrescriptionDetail\n"
                    + "    WHERE PresID = ?\n"
                    + ")";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + keyword + "%");
            pst.setString(2, PresID);
            ResultSet rs = pst.executeQuery();
            if(rs!=null){
                while(rs.next()){
                    String medID = rs.getString("MedID");
                    String medName = rs.getString("MedName");
                    float medPrice = rs.getFloat("MedPrice");
                    String medDes = rs.getString("MedDescription");
                    int remaining = rs.getInt("RemainingQuantity");
                    Medicine med = new Medicine(medID, medName, medPrice, medDes, remaining);
                    list.add(med);
                }
            }
            
        }
        cn.close();
        return list;
    }
}
