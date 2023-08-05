/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Users;
import Utils.DBUtils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class UserDAO {

    public static ArrayList<Users> getAllUsers() throws Exception {
        Connection cn = null;
        ArrayList<Users> list = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
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
                        Users user = new Users(userID, email, Password, fullname, img, gender, phone, address, birthdate, status, roleid);
                        list.add(user);
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

    public static boolean updateAccountStatus(String email, int status) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;
        if (cn != null) {
            String sql = "update Users set Status = ? where Email = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, status);
            pst.setString(2, email);
            kq = pst.executeUpdate();
            if (kq == 1) {
                trig = true;
            }
            cn.close();
        }
        return trig;
    }

    public static Users getUsersbyUserID(String userid) throws Exception {
        Connection cn = null;
        Users user = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users "
                        + "where UserID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userid);
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

    public static Users getUsers(String username, String password) throws Exception {
        Connection cn = null;
        Users user = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users "
                        + "where Status = 0 and (Email = ? or Phone = ?) and Password = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, username);
                pst.setString(3, md5(password));
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

    public static Users getUsersWithMail(String email) throws Exception {
        Connection cn = null;
        Users user = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users "
                        + "where (Email = ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userID = rs.getString("UserID");
                    String Email = rs.getString("Email");
                    String Password = rs.getString("Password");
                    String fullname = rs.getString("Fullname");
                    String img = rs.getString("Img");
                    String gender = rs.getString("Gender");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String birthdate = rs.getString("BirthDate");
                    int status = rs.getInt("Status");
                    int roleid = rs.getInt("RoleID");
                    user = new Users(userID, Email, Password, fullname, img, gender, phone, address, birthdate, status, roleid);
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

    public static Users getUsersWithPhone(String phoneNumber) throws Exception {
        Connection cn = null;
        Users user = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select UserID, Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID from Users "
                        + "where (Phone = ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, phoneNumber);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userID = rs.getString("UserID");
                    String email = rs.getString("Email");
                    String Password = rs.getString("Password");
                    String fullname = rs.getString("Fullname");
                    String img = rs.getString("Img");
                    String gender = rs.getString("Gender");
                    String Phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String birthdate = rs.getString("BirthDate");
                    int status = rs.getInt("Status");
                    int roleid = rs.getInt("RoleID");
                    user = new Users(userID, email, Password, fullname, img, gender, Phone, address, birthdate, status, roleid);
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

    public static String md5(String msg) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(msg.getBytes());
            byte byteData[] = md.digest();
            //convert the byte to hex format method 1
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            return "";
        }
    }

    public static boolean updateUserPassword(String email, String newPassword) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;
        try {
            //cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update dbo.Users set Password = ? where Email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, md5(newPassword));
                pst.setString(2, email);

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

    public static boolean addUser(String newMail, String newPassworrd, String newFullname, String newPhoneNumber) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "INSERT INTO Users (Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID) \n"
                        + "VALUES(?, ?, ?, null, null, null, null, ?, 0, 4)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newMail);
                pst.setString(2, md5(newPassworrd));
                pst.setString(3, newFullname);
                pst.setString(4, newPhoneNumber);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }
    
    public static boolean addUser(Users user)
    {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Users (Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID) \n"
                        + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                
                pst.setString(1, user.getEmail());
                pst.setString(2, md5(user.getPassword()));
                pst.setString(3, user.getFullname());
                pst.setString(4, user.getImage());
                pst.setString(5, user.getGender());
                pst.setString(6, user.getAddress());
                pst.setString(7, user.getBirthDate());
                pst.setString(8, user.getPhone());
                pst.setInt(9, user.getStatus());
                pst.setInt(10, user.getRoleID());
                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return trig;
    }
    
    public static boolean addUser(String newMail, String newPassworrd, String newFullname, String newImg, String newPhoneNumber) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "INSERT INTO Users (Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID) \n"
                        + "VALUES(?, ?, ?, ?, null, null, null, ?, 0, 4)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newMail);
                pst.setString(2, md5(newPassworrd));
                pst.setString(3, newFullname);
                pst.setString(4, newImg);
                pst.setString(5, newPhoneNumber);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }

    public static boolean addUserWithoutPassword(String newMail, String newFullname, String newImg, String newPhoneNumber, int status) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "INSERT INTO Users (Email, Password, Fullname, Img, Gender, Address, BirthDate, Phone, Status, RoleID) \n"
                        + "VALUES(?, null, ?, ?, null, null, null, ?, 0, 4)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newMail);
                pst.setString(2, newFullname);
                pst.setString(3, newImg);
                pst.setString(4, newPhoneNumber);
                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }

    //Check regex
    public static boolean isMailRightFormat(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isPhoneRightFormat(String phone) {
        return phone.matches("^0\\d{9}$");
    }

    public static boolean isPasswordRightFormat(String password) {
        return true;
    }

    public static boolean isPasswordLengthValidated(String password) {
        return password.length() >= 10;
    }

    public static boolean updateUserImage(String email, String newImage)
    {
         Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE dbo.Users SET Img =  ? Where Email = ?";
                
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newImage);
                pst.setString(2, email);

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
    
    public static boolean updateUser(String email, String newFullName, String newGender, String newPhone, String newAddress, String newBirthDate) throws Exception {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE dbo.Users SET Fullname = ?, Gender = ?, Address = ?, Phone = ?";

                if (newBirthDate != null) {
                    sql += ", BirthDate = ?";
                }

                sql += " WHERE Email = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newFullName);
                pst.setString(2, newGender);
                pst.setString(3, newAddress);
                pst.setString(4, newPhone);

                int parameterIndex = 5; // Index for the BirthDate parameter

                if (newBirthDate != null) {
                    Date birthDate = Date.valueOf(newBirthDate);
                    pst.setDate(parameterIndex, birthDate);
                    parameterIndex++; // Increment the parameter index
                }

                pst.setString(parameterIndex, email);

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

    public static String getCusID(String UserID) throws Exception {
        String CusID = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT CusID\n"
                    + "FROM Customers WHERE UserID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, UserID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                CusID = rs.getString("CusID");
            }

        }
        return CusID;
    }
}
