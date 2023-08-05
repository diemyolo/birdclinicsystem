/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import static DAO.UserDAO.md5;
import DTO.Customers;
import DTO.Users;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CustomersDAO {
    //diemyolo lam nhe
    public static String getCustomerID(String userid){
        Connection cn = null;
        String cusid = "";
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select CusID from Customers where UserID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userid);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    cusid = rs.getString("CusID");
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
        return cusid;
    }
    
    public static ArrayList<Customers> getAllCustomers() throws Exception {
        Connection cn = null;
        ArrayList<Customers> list = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select CusID, UserID from Customers";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while(rs.next()){
                        String cusID = rs.getString("CusID");
                        String userID = rs.getString("UserID");
                        Customers customer = new Customers(cusID, userID); 
                        list.add(customer);
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
    public static boolean addCustomer(String userID)
    {
        Connection cn = null;
        
        int kq = 0;
        boolean trig = false;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Insert into Customers (UserID) Values (?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userID);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }

    public static Users getUserByCusID(String cusID){
        Connection cn = null;
        Users user = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select Users.UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users\n" +
                            "join Customers on Users.UserID = Customers.UserID\n" +
                            "where Status = 0 and CusID = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, cusID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userID = rs.getString("UserID");
                    String email = rs.getString("Email");
                    String Password = rs.getString("Password");
                    String fullname = rs.getString("Fullname");
                    String img = rs.getString("Img");
                    String gender = rs.getString("Gender");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String birthdate = rs.getString("BirthDate");
                    int status = rs.getInt("Status");
                    int roleid = rs.getInt("RoleID");
                    user = new Users(userID, email, Password, fullname, img, gender, phone, address, birthdate, status, roleid);
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
        return user;
    }
    
    public static ArrayList<Customers> searchCustomers(String keyword, String searchby, String Status) throws Exception {
        ArrayList<Customers> listCustomer = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select c.CusID, c.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Customers c left join dbo.Users u on c.UserID = u.UserID";
            if (searchby.equalsIgnoreCase("cusid"))
            {
                sql = sql + " where CusID like ?";
            } else if (searchby.equalsIgnoreCase("cusmail"))
            {
                sql = sql + " where Email like ?";
            } else if (searchby.equalsIgnoreCase("cusname"))
            {
                sql = sql + " where Fullname like ?";
            } else if (searchby.equalsIgnoreCase("cusphone"))
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
            if (rs != null) {
                while (rs.next()) {
                    String cusId = rs.getString("CusID");
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
                    Customers customer = new Customers(cusId, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listCustomer.add(customer);
                }
            }
            cn.close();
        }
        return listCustomer;
    }
}
