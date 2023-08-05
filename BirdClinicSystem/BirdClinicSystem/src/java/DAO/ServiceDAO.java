/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Services;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class ServiceDAO {

    public static ArrayList<Services> getServices(String keyword) {
        ArrayList<Services> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select ServID, ServName, Price, Serv_img, Ser_description from Services where ServName like ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String id = rs.getString("ServID");
                        String name = rs.getString("ServName");
                        float price = rs.getFloat("Price");
                        String imgpath = rs.getString("Serv_img");
                        String description = rs.getString("Ser_description");
                        Services serv = new Services(id, name, price, imgpath, description);
                        list.add(serv);
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

    public static ArrayList<Services> getServiceListByAppointmentID(String appID) {
        ArrayList<Services> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select Services.ServID, Services.ServName, Services.Price, \n"
                        + " Services.Serv_img, Services.Ser_description\n"
                        + "from (Appointments join AppointmentService \n"
                        + "on Appointments.AppID = AppointmentService.AppID)\n"
                        + "join Services on AppointmentService.ServID = Services.ServID\n"
                        + "where Appointments.AppID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, appID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String ServID = rs.getString("ServID");
                        String ServName = rs.getString("ServName");
                        float Price = rs.getFloat("Price");
                        String Serv_img = rs.getString("Serv_img");
                        String Ser_description = rs.getString("Ser_description");
                        
                        Services serv = new Services(ServID, ServName, Price, Serv_img, Ser_description);
                        list.add(serv);
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
    
     public static ArrayList<Services> getServiceListByInvoiceID(String invoiceID) {
        ArrayList<Services> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT Services.ServID, Services.ServName, Services.Price, Services.Serv_img, Services.Ser_description\n"
                        + "FROM ((Appointments\n"
                        + "JOIN AppointmentService ON Appointments.AppID = AppointmentService.AppID)\n"
                        + "JOIN Services ON AppointmentService.ServID = Services.ServID)\n"
                        + "JOIN Invoices ON Appointments.AppID = Invoices.AppID\n"
                        + "WHERE Invoices.InvID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, invoiceID);
                ResultSet rs = pst.executeQuery();
                if (rs != null)
                {
                    while (rs.next())
                    {
                        String ServID = rs.getString("ServID");
                        String ServName = rs.getString("ServName");
                        float Price = rs.getFloat("Price");
                        String Serv_img = rs.getString("Serv_img");
                        String Ser_description = rs.getString("Ser_description");

                        Services serv = new Services(ServID, ServName, Price, Serv_img, Ser_description);
                        list.add(serv);
                    }
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
        return list;
    }
    
    public static float totalServicePrice(ArrayList<Services> serviceList)
    {
        float totalPrice = 0f;
        for(Services s: serviceList)
        {
            totalPrice += s.getPrice();
        }
        return totalPrice;
    }
}
