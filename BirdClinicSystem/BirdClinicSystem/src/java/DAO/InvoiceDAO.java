/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Invoice;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class InvoiceDAO {

    public static boolean addInvoice(String appointmentID, String prescriptionID, float totalMoney, int paid) throws Exception {
        Connection cn = DBUtils.makeConnection();
        int kq = 0;
        boolean trig = false;

        try {
            if (cn != null) {
                String sql = "insert into Invoices (AppID, PresID, TotalMoney, Paid) \n"
                        + "values (?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, appointmentID);
                pst.setString(2, prescriptionID);
                pst.setFloat(3, totalMoney);
                pst.setInt(4, paid);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
        return trig;
    }
    
    public static ArrayList<Invoice> getAllInvoice() {
        Connection cn = null;
        ArrayList<Invoice> list = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select InvID, AppID, PresID, TotalMoney, Paid from Invoices";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    String invoiceID = rs.getString("InvID");
                    String appointmentID = rs.getString("AppID");
                    String prescriptionID = rs.getString("PresID");
                    float totalMoney = rs.getFloat("TotalMoney");
                    int paid = rs.getInt("Paid");
                    Invoice invoice = new Invoice(invoiceID, appointmentID, prescriptionID, totalMoney, paid);
                    list.add(invoice);
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
    
    public static Invoice getInvoiceInfo() {
        Connection cn = null;
        Invoice invoice = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select InvID, AppID, PresID, TotalMoney, Paid from Invoices";
                PreparedStatement pst = cn.prepareStatement(sql);

                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String invoiceID = rs.getString("InvID");
                    String appointmentID = rs.getString("AppID");
                    String prescriptionID = rs.getString("PresID");
                    float totalMoney = rs.getFloat("TotalMoney");
                    int paid = rs.getInt("Paid");

                    invoice = new Invoice(invoiceID, appointmentID, prescriptionID, totalMoney, paid);
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
        return invoice;
    }
    
    public static Invoice getInvoicebyAppointmentID(String appointmentID) {
        Connection cn = null;
        Invoice invoice = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select InvID, AppID, PresID, TotalMoney, Paid from Invoices\n"
                        + "where AppID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, appointmentID);

                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String invoiceID = rs.getString("InvID");
                    String prescriptionID = rs.getString("PresID");
                    float totalMoney = rs.getFloat("TotalMoney");
                    int paid = rs.getInt("Paid");

                    invoice = new Invoice(invoiceID, appointmentID, prescriptionID, totalMoney, paid);
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
        return invoice;
    }

    public static boolean updateInvoice(String appointmentID, float totalMoney, int paid) throws Exception {
        Connection cn = null;
        int kq = 0;
        boolean trig = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "update Invoices\n"
                        + "set TotalMoney = ?, Paid = ?\n"
                        + "where AppID = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setFloat(1, totalMoney);
                pst.setInt(2, paid);
                pst.setString(3, appointmentID);

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
    
    public static ArrayList<Invoice> searchInvoice(String keyword, String searchby, String startdate, String enddate) throws Exception {
        ArrayList<Invoice> listInvoice = new ArrayList<>();
        if(keyword == null )
        {
            return getAllInvoice();
        }
        Connection cn = DBUtils.makeConnection();
        if (cn != null)
        {
            String sql = " ";
            if (searchby.equalsIgnoreCase("cusname"))
            {
                sql = "Select i.InvID, i.AppID, i.PresID, i.TotalMoney, i.Paid\n"
                        + "from ((dbo.Invoices i join dbo.Appointments a on i.AppID = a.AppID)\n"
                        + "join dbo.Customers c on a.CusID = c.CusID) join dbo.Users u on c.UserID = u.UserID\n"
                        + "where u.Fullname like ?";
                
            } else if (searchby.equalsIgnoreCase("invoiceid"))
            {
                sql = "Select i.InvID, i.AppID, i.PresID, i.TotalMoney, i.Paid\n"
                        + "from dbo.Invoices i join dbo.Appointments a on i.AppID = a.AppID\n"
                        + "where InvID like ? ";
            } else if (searchby.equalsIgnoreCase("docname"))
            {
                sql = "Select i.InvID, i.AppID, i.PresID, i.TotalMoney, i.Paid \n"
                        + "from ((dbo.Invoices i join dbo.Appointments a on i.AppID = a.AppID) join dbo.Doctors d on a.DocID = d.DocID) join dbo.Users u on d.UserID = u.UserID\n"
                        + "where u.Fullname like ? ";
            } 
            if (startdate != null && enddate != null && !startdate.isEmpty() && !enddate.isEmpty())
            {
                sql = sql + "and a.AppointDate between ? and ?";

            } 
            else if (enddate != null && !enddate.isEmpty())
            {
                sql = sql + " and a.AppointDate <= ?";

            }
            else if (startdate != null && !startdate.isEmpty())
            {
                sql = sql + " and a.AppointDate >= ?";
                
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + keyword + "%");
            if (startdate != null && enddate != null && !startdate.isEmpty() && !enddate.isEmpty())
                {
                    Date StartDate = Date.valueOf(startdate);
                    Date EndDate = Date.valueOf(enddate);
                    pst.setDate(2, StartDate);
                    pst.setDate(3, EndDate);
                }
            else if (enddate != null && !enddate.isEmpty())
                {
                    Date EndDate = Date.valueOf(enddate);
                    pst.setDate(2, EndDate);
                }
            else if (startdate != null && !startdate.isEmpty())
                {
                    Date StartDate = Date.valueOf(startdate);
                    pst.setDate(2, StartDate);
                }
            ResultSet rs = pst.executeQuery();
            if (rs != null)
            {
                while (rs.next())
                {
                    String invoiceID = rs.getString("InvID");
                    String appointmentID = rs.getString("AppID");
                    String prescriptionID = rs.getString("PresID");
                    float totalMoney = rs.getFloat("TotalMoney");
                    int paid = rs.getInt("Paid");
                    Invoice invoice = new Invoice(invoiceID, appointmentID, prescriptionID, totalMoney, paid);
                    listInvoice.add(invoice);
                }
            }
            cn.close();
        }
        return listInvoice;
    }
}
