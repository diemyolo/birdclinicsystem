/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import DAO.BirdDAO;
import DAO.DoctorDAO;
import DAO.UserDAO;
import static DAO.UserDAO.updateUser;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class TestConnection {
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
            return  sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            return "";
        }
    }
    public static void main(String[] args) {
//        try{
//         Users user = UserDAO.getUsers("thorkien510@gmail.com", "thorkienpassword");
//         if(user.getRoleID() == 2){
//             System.out.println("Ngon");
//         }else{
//             System.out.println("Chetme");
//         }
//        }catch(Exception e){
//            e.printStackTrace();
//        }
        System.out.println(md5("admin"));
//        //test getDoctorList
//        try{
//            ArrayList<Doctor> doc = DoctorDAO.getDoctorList();
//            for (Doctor doctor : doc) {
//                System.out.println(doctor.getBirthDate());
//            }
//        }catch(Exception e){
//            e.printStackTrace();
//        }
//        //test valueOf Date
//        Date birthDatetmp = Date.valueOf("2003-01-01");
//        System.out.println(birthDatetmp);
        //test UpdateUsers
//        try{
//            boolean result = updateUser("user011@gmail.com", "Tran Tien Date", "Male", "0961164107", "45 Le Dinh Tham", "2003-08-13");
//            if(result){
//                System.out.println("Ngon");
//            }else{
//                System.out.println("Chetme");
//            }
//        }
//        catch(Exception e){
//            e.printStackTrace();
//        }
        //test getAllCustomerBirds(int UserID, String keyword)
//        try{
//            ArrayList<Birds> list = BirdDAO.getAllCustomerBirds(11);
//            for (Birds birds : list) {
//                System.out.println(birds.getBird_name() + " " + birds.getBird_type());
//            }
//        }catch(Exception e){
//            e.printStackTrace();
//        }
        //test Update Birds
        
//        try{
//            boolean result = BirdDAO.updateBird(7, "sparror", "Daniel", "Old", "Like to eat bread crumbs", "Have broken his wings once");
//            if(result){
//                System.out.println("Ngon");
//            }else{
//                System.out.println("Chetme");
//            }
//        }catch(Exception e){
//            e.printStackTrace();
//        }
    }
}
