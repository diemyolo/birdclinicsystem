/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.MedicineCategory;
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
public class MedicineCategoryDAO {

    public static MedicineCategory getMedicineCategoryByID(String medcateid) {
        MedicineCategory medcate = new MedicineCategory();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedCategoryID, MedCategoryName from MedicineCategory where MedCategoryID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medcateid);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String MedCateID = rs.getString("MedCategoryID");
                    String MedCateName = rs.getString("MedCategoryName");
                    medcate = new MedicineCategory(MedCateID, MedCateName);
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
        return medcate;
    }

    public static MedicineCategory getMedicineCategoryByName(String medcatename) {
        MedicineCategory medcate = new MedicineCategory();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedCategoryID, MedCategoryName from MedicineCategory where MedCategoryName = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medcatename);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String MedCateID = rs.getString("MedCategoryID");
                    String MedCateName = rs.getString("MedCategoryName");
                    medcate = new MedicineCategory(MedCateID, MedCateName);
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
        return medcate;
    }

    public static ArrayList<MedicineCategory> getAllMedicineCategory() {
        ArrayList<MedicineCategory> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedCategoryID, MedCategoryName from MedicineCategory";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String MedCateID = rs.getString("MedCategoryID");
                        String MedCateName = rs.getString("MedCategoryName");
                        MedicineCategory medcate = new MedicineCategory(MedCateID, MedCateName);
                        list.add(medcate);
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

    public static ArrayList<String> getAllMedicineCategoryName() {
        ArrayList<String> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select MedCategoryID, MedCategoryName from MedicineCategory";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String MedCateName = rs.getString("MedCategoryName");
                        list.add(MedCateName);
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

    public static boolean checkMedCateNameExist(String medcatename) {
        boolean result = true;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Select MedCategoryName from MedicineCategory where MedCategoryName = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medcatename);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    result = true;
                } else {
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

    public static boolean addMedicineCategory(String medcatename) {
        boolean result = false;
        Connection cn = null;
        int kq = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "insert into MedicineCategory (MedCategoryName) Values (?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, medcatename);
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

    public static String getNextMedicineCategoryID() {
        String medcateid = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "DECLARE @MaxID INT\n"
                        + "SELECT @MaxID = MAX(ID) FROM MedicineCategory\n"
                        + "\n"
                        + "DECLARE @NextCateID NVARCHAR(10)\n"
                        + "SET @NextCateID = 'CATE-' + RIGHT('0000' + CAST(ISNULL(@MaxID, 0) + 1 AS NVARCHAR(4)), 4)\n"
                        + "\n"
                        + "SELECT @NextCateID AS NextCategoryID";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        medcateid = rs.getString("NextCategoryID");
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
        return medcateid;
    }
    
    public static void main(String[] args) {
        System.out.print(getNextMedicineCategoryID());
    }
}
