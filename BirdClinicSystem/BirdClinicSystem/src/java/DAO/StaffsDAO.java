/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Staffs;
import DTO.Users;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class StaffsDAO {

    public static void addStaff(Users user) {
        String userID = user.getUserID();

        Connection cn = null;
        int kq = 0;
        boolean trig = false;

        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "INSERT INTO Staff (UserID) \n"
                        + "VALUES(?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userID);

                kq = pst.executeUpdate();
                if (kq == 1)
                {
                    trig = true;
                }
            }

        } catch (Exception e)
        {

        }
    }

    public static String getStaffID(String UserID) {
        Connection cn = null;
        String staffid = "";
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "select StaffID from Staff where UserID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, UserID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next())
                {
                    staffid = rs.getString("StaffID");
                }
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        } finally
        {
            if (cn != null)
            {
                try
                {
                    cn.close();
                } catch (Exception e)
                {
                    e.printStackTrace();
                }
            }
        }
        return staffid;
    }

    public static ArrayList<Staffs> getAllStaff() throws Exception {
        ArrayList<Staffs> listStaff = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null){
            String sql = "Select s.StaffID 'StaffID', s.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Staff s left join dbo.Users u on s.UserID = u.UserID";
            Statement pst = cn.createStatement();
            ResultSet rs = pst.executeQuery(sql);
            if (rs != null)
            {
                while (rs.next())
                {
                    String staffId = rs.getString("StaffID");
                    String userid = rs.getString("UserID");
                    String email = rs.getString("Email");
                    String password = rs.getString("Password");
                    String fullName = rs.getString("Fullname");
                    String img = rs.getString("Img");
                    String gender = rs.getString("Gender");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String birthDate = rs.getString("BirthDate");
                    int status = rs.getInt("Status");
                    int RoleID = rs.getInt("RoleID");
                    Staffs staff = new Staffs(staffId, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listStaff.add(staff);
                }
            }
            cn.close();
        }
        return listStaff;
    }

    public static ArrayList<Staffs> searchStaff(String keyword, String searchby, String Status) throws Exception {
        ArrayList<Staffs> listStaff = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null)
        {
            String sql = "Select s.StaffID, s.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Staff s left join dbo.Users u on s.UserID = u.UserID";
            if (searchby.equalsIgnoreCase("staffid"))
            {
                sql = sql + " where StaffID like ?";
            } else if (searchby.equalsIgnoreCase("staffmail"))
            {
                sql = sql + " where Email like ?";
            } else if (searchby.equalsIgnoreCase("staffname"))
            {
                sql = sql + " where Fullname like ?";
            } else if (searchby.equalsIgnoreCase("staffphone"))
            {
                sql = sql + " where Phone like ?";
            }
            if (Status.equalsIgnoreCase("active"))
            {
                sql = sql + " and Status = 0";
            } else if (Status.equalsIgnoreCase("suspended"))
            {
                sql = sql + " and Status = 1";
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null)
            {
                while (rs.next())
                {
                    String staffId = rs.getString("StaffID");
                    String userid = rs.getString("UserID");
                    String email = rs.getString("Email");
                    String password = rs.getString("Password");
                    String fullName = rs.getString("Fullname");
                    String img = rs.getString("Img");
                    String gender = rs.getString("Gender");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String birthDate = rs.getString("BirthDate");
                    int status = rs.getInt("Status");
                    int RoleID = rs.getInt("RoleID");
                    Staffs staff = new Staffs(staffId, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listStaff.add(staff);
                }
            }
            cn.close();
        }
        return listStaff;
    }
}