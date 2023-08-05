/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.AppointmentsForm;
import DTO.Appointments;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Time;
import java.sql.Types;
import java.time.LocalTime;
import java.time.LocalDate;

/**
 *
 * @author ASUS
 */
public class AppointmentDAO {

    public static int addNewAppointment(String CusID, String DocID, String BirdID, String AppointDate, int SlotID, int Status, String services, String note) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            //insert appointment table
            String sql = "INSERT INTO Appointments (CusID, DocID, BirdID, AppointDate, SlotID, Status, Note)\n"
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, CusID);
            pst.setString(2, DocID);
            pst.setString(3, BirdID);
            pst.setString(4, AppointDate);
            pst.setInt(5, SlotID);
            pst.setInt(6, Status);
            if (note.equals("")) {
                pst.setNull(7, Types.NULL);
            } else {
                pst.setString(7, note);
            }
            result = pst.executeUpdate();

            //get AppID
            String getAppID = "SELECT AppID\n"
                    + "FROM Appointments a WHERE a.AppointDate = ? and a.CusID = ? and SlotID = ?";
            PreparedStatement pst1 = cn.prepareStatement(getAppID);
            pst1.setString(1, AppointDate);
            pst1.setString(2, CusID);
            pst1.setInt(3, SlotID);
            ResultSet rs1 = pst1.executeQuery();
            String AppID = null;
            if (rs1 != null && rs1.next()) {
                AppID = rs1.getString("AppID");
            }

            //insert table AppService
            String[] serviceList = services.split(",");
            int count = 0;
            String ServID = null;
            for (String element : serviceList) {
                count++;
            }

            for (int i = 0; i < count; i++) {
                String getServiceID = "SELECT ServID\n"
                        + "FROM Services WHERE ServName = ?";
                PreparedStatement pst2 = cn.prepareStatement(getServiceID);
                pst2.setString(1, serviceList[i].trim());
                ResultSet rs2 = pst2.executeQuery();
                if (rs2 != null && rs2.next()) {
                    ServID = rs2.getString("ServID");
                }

                String insertServiceApp = "INSERT INTO AppointmentService(AppID, ServID)\n"
                        + "VALUES (?, ?)";
                PreparedStatement pst3 = cn.prepareStatement(insertServiceApp);
                pst3.setString(1, AppID);
                pst3.setString(2, ServID);
                int result2 = pst3.executeUpdate();
                if (result2 != 1) {
                    result = 0;
                }
            }

            cn.close();
        }

        return result;
    }

    public static String getBirdID(String birdName) throws Exception {
        String BirdID = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT BirdID\n"
                    + "FROM Birds WHERE Bird_name = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, birdName);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                BirdID = rs.getString("BirdID");
            }
            cn.close();
        }
        return BirdID;

    }

    public static ArrayList<AppointmentsForm> getAppointmentListByEmail(String email, String startdate, String enddate) throws Exception {
        ArrayList<AppointmentsForm> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    A.AppID as 'AppID', \n"
                        + "    UC.Fullname as 'CustomerName', \n"
                        + "    UC.Phone as 'Phone', \n"
                        + "    UC.Address as 'Address', \n"
                        + "    SL.StartTime as 'StartTime', \n"
                        + "    SL.EndTime as 'EndTime',  \n"
                        + "    A.AppointDate as 'Date', \n"
                        + "    B.Bird_name 'BirdName',\n"
                        + "    B.Bird_type as 'Species', \n"
                        + "    STRING_AGG(S.ServName, ', ') as 'ServiceNames',\n"
                        + "    U.Fullname as 'DoctorName', \n"
                        + "    A.Status as 'Status', \n"
                        + "    A.Note as 'CustomerNote'\n"
                        + "FROM dbo.Appointments A\n"
                        + "INNER JOIN dbo.Slot SL ON A.SlotID = SL.SlotID\n"
                        + "INNER JOIN dbo.Birds B ON A.BirdID = B.BirdID\n"
                        + "INNER JOIN dbo.AppointmentService ASV ON A.AppID = ASV.AppID\n"
                        + "INNER JOIN dbo.Services S ON ASV.ServID = S.ServID\n"
                        + "INNER JOIN dbo.Doctors D on A.DocID = D.DocID\n"
                        + "INNER JOIN dbo.Users U on D.UserID = U.UserID\n"
                        + "INNER JOIN dbo.Customers C on A.CusID = C.CusID\n"
                        + "INNER JOIN dbo.Users UC on C.UserID = UC.UserID\n"
                        + "Where UC.Email = ?\n"
                        + "GROUP BY A.AppID, UC.Fullname, UC.Phone, UC.Address, SL.StartTime, SL.EndTime, A.AppointDate, B.Bird_name, B.Bird_type, U.Fullname, A.Status, A.Note";
                if ((!startdate.equals("") && !enddate.equals(""))) {
                    sql = sql + " having (A.AppointDate between ? and ?)";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                if (!startdate.equals("") && !enddate.equals("")) {
                    Date StartDate = Date.valueOf(startdate);
                    Date EndDate = Date.valueOf(enddate);
                    pst.setDate(2, StartDate);
                    pst.setDate(3, EndDate);
                }
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String appID = rs.getString("AppID");
                        String customerName = rs.getString("CustomerName");
                        String phone = rs.getString("Phone");
                        String address = rs.getString("Address");
                        String startTime = rs.getString("StartTime");
                        String endTime = rs.getString("EndTime");
                        String date = rs.getString("Date");
                        String birdName = rs.getString("BirdName");
                        String species = rs.getString("Species");
                        String serviceName = rs.getString("ServiceNames");
                        String doctorName = rs.getString("DoctorName");
                        int status = rs.getInt("Status");
                        String customerNote = rs.getString("CustomerNote");
                        AppointmentsForm appoint = new AppointmentsForm(appID, customerName, phone, address, startTime, endTime, date, birdName, species, serviceName, doctorName, status, customerNote);
                        list.add(appoint);
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

    public static ArrayList<AppointmentsForm> getAllAppointmentList() throws Exception {
        ArrayList<AppointmentsForm> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    A.AppID as 'AppID', \n"
                        + "    UC.Fullname as 'CustomerName', \n"
                        + "    UC.Phone as 'Phone', \n"
                        + "    UC.Address as 'Address', \n"
                        + "    SL.StartTime as 'StartTime', \n"
                        + "    SL.EndTime as 'EndTime',  \n"
                        + "    A.AppointDate as 'Date', \n"
                        + "    B.Bird_name 'BirdName',\n"
                        + "    B.Bird_type as 'Species', \n"
                        + "    STRING_AGG(S.ServName, ', ') as 'ServiceNames',\n"
                        + "    U.Fullname as 'DoctorName', \n"
                        + "    A.Status as 'Status', \n"
                        + "    A.Note as 'CustomerNote'\n"
                        + "FROM dbo.Appointments A\n"
                        + "INNER JOIN dbo.Slot SL ON A.SlotID = SL.SlotID\n"
                        + "INNER JOIN dbo.Birds B ON A.BirdID = B.BirdID\n"
                        + "INNER JOIN dbo.AppointmentService ASV ON A.AppID = ASV.AppID\n"
                        + "INNER JOIN dbo.Services S ON ASV.ServID = S.ServID\n"
                        + "INNER JOIN dbo.Doctors D on A.DocID = D.DocID\n"
                        + "INNER JOIN dbo.Users U on D.UserID = U.UserID\n"
                        + "INNER JOIN dbo.Customers C on A.CusID = C.CusID\n"
                        + "INNER JOIN dbo.Users UC on C.UserID = UC.UserID\n"
                        + "GROUP BY A.AppID, UC.Fullname, UC.Phone, UC.Address, SL.StartTime, SL.EndTime, A.AppointDate, B.Bird_name, B.Bird_type, U.Fullname, A.Status, A.Note";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String appID = rs.getString("AppID");
                        String customerName = rs.getString("CustomerName");
                        String phone = rs.getString("Phone");
                        String address = rs.getString("Address");
                        String startTime = rs.getString("StartTime");
                        String endTime = rs.getString("EndTime");
                        String date = rs.getString("Date");
                        String birdName = rs.getString("BirdName");
                        String species = rs.getString("Species");
                        String serviceName = rs.getString("ServiceNames");
                        String doctorName = rs.getString("DoctorName");
                        int status = rs.getInt("Status");
                        String customerNote = rs.getString("CustomerNote");
                        AppointmentsForm appoint = new AppointmentsForm(appID, customerName, phone, address, startTime, endTime, date, birdName, species, serviceName, doctorName, status, customerNote);
                        list.add(appoint);
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

    public static AppointmentsForm getAppointmentbyInvoiceID(String invoiceID) throws Exception {
        AppointmentsForm app = new AppointmentsForm();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "A.AppID as 'AppID', \n"
                        + "UC.Fullname as 'CustomerName',\n"
                        + "UC.Phone as 'Phone', \n"
                        + "UC.Address as 'Address',\n"
                        + "SL.StartTime as 'StartTime', \n"
                        + "SL.EndTime as 'EndTime',  \n"
                        + "A.AppointDate as 'Date', \n"
                        + "B.Bird_name 'BirdName',\n"
                        + "B.Bird_type as 'Species', \n"
                        + "STRING_AGG(S.ServName, ', ') as 'ServiceNames',\n"
                        + "U.Fullname as 'DoctorName', \n"
                        + "A.Status as 'Status', \n"
                        + "A.Note as 'CustomerNote'\n"
                        + "FROM dbo.Appointments A\n"
                        + "INNER JOIN dbo.Slot SL ON A.SlotID = SL.SlotID\n"
                        + "INNER JOIN dbo.Birds B ON A.BirdID = B.BirdID\n"
                        + "INNER JOIN dbo.AppointmentService ASV ON A.AppID = ASV.AppID\n"
                        + "INNER JOIN dbo.Services S ON ASV.ServID = S.ServID\n"
                        + "INNER JOIN dbo.Doctors D on A.DocID = D.DocID\n"
                        + "INNER JOIN dbo.Users U on D.UserID = U.UserID\n"
                        + "INNER JOIN dbo.Customers C on A.CusID = C.CusID\n"
                        + "INNER JOIN dbo.Users UC on C.UserID = UC.UserID\n"
                        + "INNER JOIN dbo.Invoices I on A.AppID = I.AppID\n"
                        + "where InvID = ?\n"
                        + "GROUP BY A.AppID, UC.Fullname, UC.Phone, UC.Address, SL.StartTime, SL.EndTime, A.AppointDate, B.Bird_name, B.Bird_type, U.Fullname, A.Status, A.Note";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, invoiceID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {

                    String appID = rs.getString("AppID");
                    String customerName = rs.getString("CustomerName");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    String startTime = rs.getString("StartTime");
                    String endTime = rs.getString("EndTime");
                    String date = rs.getString("Date");
                    String birdName = rs.getString("BirdName");
                    String species = rs.getString("Species");
                    String serviceName = rs.getString("ServiceNames");
                    String doctorName = rs.getString("DoctorName");
                    int status = rs.getInt("Status");
                    String customerNote = rs.getString("CustomerNote");
                    app = new AppointmentsForm(appID, customerName, phone, address, startTime, endTime, date, birdName, species, serviceName, doctorName, status, customerNote);
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
        return app;
    }

    public static ArrayList<AppointmentsForm> getAllAppointmentList(String keyword, String searchby, String Status, String startdate, String enddate) throws Exception {
        ArrayList<AppointmentsForm> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    A.AppID as 'AppID', \n"
                        + "    UC.Fullname as 'CustomerName', \n"
                        + "    UC.Phone as 'Phone', \n"
                        + "    UC.Address as 'Address', \n"
                        + "    SL.StartTime as 'StartTime', \n"
                        + "    SL.EndTime as 'EndTime',  \n"
                        + "    A.AppointDate as 'Date', \n"
                        + "    B.Bird_name 'BirdName',\n"
                        + "    B.Bird_type as 'Species', \n"
                        + "    STRING_AGG(S.ServName, ', ') as 'ServiceNames',\n"
                        + "    U.Fullname as 'DoctorName', \n"
                        + "    A.Status as 'Status', \n"
                        + "    A.Note as 'CustomerNote'\n"
                        + "FROM dbo.Appointments A\n"
                        + "INNER JOIN dbo.Slot SL ON A.SlotID = SL.SlotID\n"
                        + "INNER JOIN dbo.Birds B ON A.BirdID = B.BirdID\n"
                        + "INNER JOIN dbo.AppointmentService ASV ON A.AppID = ASV.AppID\n"
                        + "INNER JOIN dbo.Services S ON ASV.ServID = S.ServID\n"
                        + "INNER JOIN dbo.Doctors D on A.DocID = D.DocID\n"
                        + "INNER JOIN dbo.Users U on D.UserID = U.UserID\n"
                        + "INNER JOIN dbo.Customers C on A.CusID = C.CusID\n"
                        + "INNER JOIN dbo.Users UC on C.UserID = UC.UserID\n"
                        + "GROUP BY A.AppID, UC.Fullname, UC.Phone, UC.Address, SL.StartTime, SL.EndTime, A.AppointDate, B.Bird_name, B.Bird_type, U.Fullname, A.Status, A.Note";
                if (searchby.equalsIgnoreCase("appid")) {
                    sql = sql + "  having A.AppID like ?";
                } else if (searchby.equalsIgnoreCase("cusname")) {
                    sql = sql + "  having UC.Fullname like ?";
                }
                if (Status.equalsIgnoreCase("pending")) {
                    sql = sql + " and A.Status = 1";
                } else if (Status.equalsIgnoreCase("completed")) {
                    sql = sql + " and A.Status = 0";
                }
                if ((!startdate.equals("") && !enddate.equals(""))) {
                    sql = sql + " and (A.AppointDate between ? and ?)";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                if (!startdate.equals("") && !enddate.equals("")) {
                    Date StartDate = Date.valueOf(startdate);
                    Date EndDate = Date.valueOf(enddate);
                    pst.setDate(2, StartDate);
                    pst.setDate(3, EndDate);
                }
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String appID = rs.getString("AppID");
                        String customerName = rs.getString("CustomerName");
                        String phone = rs.getString("Phone");
                        String address = rs.getString("Address");
                        String startTime = rs.getString("StartTime");
                        String endTime = rs.getString("EndTime");
                        String date = rs.getString("Date");
                        String birdName = rs.getString("BirdName");
                        String species = rs.getString("Species");
                        String serviceName = rs.getString("ServiceNames");
                        String doctorName = rs.getString("DoctorName");
                        int status = rs.getInt("Status");
                        String customerNote = rs.getString("CustomerNote");
                        AppointmentsForm appoint = new AppointmentsForm(appID, customerName, phone, address, startTime, endTime, date, birdName, species, serviceName, doctorName, status, customerNote);
                        list.add(appoint);
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

    public static Appointments getAppointmentByID(String AppID) throws Exception {
        Appointments app = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT a.AppID, a.CusID, a.DocID, a.BirdID, a.AppointDate, a.SlotID, a.Status\n"
                    + "FROM Appointments a\n"
                    + "WHERE a.AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, AppID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String CusID = rs.getString("CusID");
                String DocID = rs.getString("DocID");
                String BirdID = rs.getString("BirdID");
                String AppointDate = rs.getString("AppointDate");
                int SlotID = rs.getInt("SlotID");
                int Status = rs.getInt("Status");
                app = new Appointments(AppID, CusID, DocID, BirdID, AppointDate, SlotID, Status);
            }
        }

        return app;
    }

    public static Appointments getAppointmentByIDWithServices(String AppID) throws Exception {
        Appointments app = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT a.AppID, a.CusID, a.DocID, a.BirdID, a.AppointDate, a.SlotID, a.Status, STRING_AGG(s.ServName, ', ') AS 'Services'\n"
                    + "FROM Appointments a\n"
                    + "INNER JOIN AppointmentService asrv ON a.AppID = asrv.AppID\n"
                    + "INNER JOIN Services s ON asrv.ServID = s.ServID\n"
                    + "WHERE a.AppID = ?\n"
                    + "GROUP BY a.AppID, a.CusID, a.DocID, a.BirdID, a.AppointDate, a.SlotID, a.Status";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, AppID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String CusID = rs.getString("CusID");
                String DocID = rs.getString("DocID");
                String BirdID = rs.getString("BirdID");
                String AppointDate = rs.getString("AppointDate");
                int SlotID = rs.getInt("SlotID");
                int Status = rs.getInt("Status");
                String Services = rs.getString("Services");
                app = new Appointments(AppID, CusID, DocID, BirdID, AppointDate, SlotID, Status, Services);
            }
        }

        return app;
    }

    public static ArrayList<Appointments> getDoctorAppointmentList(String docID, String keyword) throws Exception {
        ArrayList<Appointments> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT A.AppID, A.CusID, A.BirdID, A.AppointDate, A.SlotID, A.Status, A.Note\n"
                    + "FROM Appointments A LEFT JOIN Customers c on A.CusID = c.CusID LEFT JOIN Users u \n"
                    + "on c.UserID = u.UserID LEFT JOIN Birds b on A.BirdID = b.BirdID\n"
                    + "WHERE A.DocID = ? AND (A.AppID LIKE ? OR u.Fullname LIKE ? OR b.Bird_name LIKE ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docID);
            pst.setString(2, "%" + keyword + "%");
            pst.setString(3, "%" + keyword + "%");
            pst.setString(4, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String appID = rs.getString("AppID");
                    String cusID = rs.getString("CusID");
                    String birdID = rs.getString("BirdID");
                    String appointDate = rs.getString("AppointDate");
                    int slotID = rs.getInt("SlotID");
                    int status = rs.getInt("Status");
                    Appointments app = new Appointments(appID, cusID, docID, birdID, appointDate, slotID, status);
                    list.add(app);
                }
            }
        }

        return list;
    }

    public static boolean checkSlotIfBooked(int slot, int date, int month, int year, String cusID) throws Exception {
        boolean result = false;
        String appointDate = year + "-" + (month + 1) + "-" + date;

        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT AppID\n"
                    + "FROM Appointments a\n"
                    + "WHERE SlotID = ? AND AppointDate = ? AND CusID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, slot);
            pst.setString(2, appointDate);
            pst.setString(3, cusID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = true;
            }
        }

        return result;
    }

    public static String getAppID(int date, int month, int year, String cusID, int slotID) throws Exception {
        String appID = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT AppID\n"
                    + "FROM Appointments\n"
                    + "WHERE AppointDate = ? AND CusID = ? AND SlotID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, year + "-" + (month + 1) + "-" + date);
            pst.setString(2, cusID);
            pst.setInt(3, slotID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                appID = rs.getString("AppID");
            }
        }
        return appID;
    }

    public static int deleteApp(String appID) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String deleteServices = "DELETE\n"
                    + "FROM AppointmentService\n"
                    + "WHERE AppID = ?";
            PreparedStatement pst2 = cn.prepareStatement(deleteServices);
            pst2.setString(1, appID);
            result = pst2.executeUpdate();

            String sql = "DELETE\n"
                    + "FROM Appointments\n"
                    + "WHERE AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, appID);
            result = pst.executeUpdate();

        }

        return result;
    }

    public static ArrayList<Integer> getAvailableSlots(String date) throws Exception {
        ArrayList<Integer> slotList = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT SlotID\n"
                    + "FROM Slot \n"
                    + "WHERE SlotID NOT IN (\n"
                    + "SELECT SlotID \n"
                    + "FROM Appointments a\n"
                    + "WHERE AppointDate = ?\n"
                    + ")";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, date);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int slot = rs.getInt("SlotID");
                    slotList.add(slot);
                }
            }
        }

        return slotList;
    }

    public static int rescheduleApp(String appID, String resDate, int resSlot) throws Exception {
        int result = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "UPDATE Appointments\n"
                    + "SET AppointDate = ?, SlotID = ?\n"
                    + "WHERE AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, resDate);
            pst.setInt(2, resSlot);
            pst.setString(3, appID);
            result = pst.executeUpdate();
        }

        return result;
    }

    public static String getAppoinmentNote(String appid) throws Exception {
        String note = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select Note from Appointments Where AppID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, appid);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                note = rs.getString("Note");
            }
        }
        return note;
    }

    public static int updateAppStatus() throws Exception {
        int result = 0;
        Time currentTime = Time.valueOf(LocalTime.now());
        Date currentDate = Date.valueOf(LocalDate.now());

        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "UPDATE Appointments SET Status = 0 WHERE Status = 1 "
                    + "AND SlotID IN (SELECT SlotID FROM Slot WHERE CONVERT(datetime, EndTime) < ?) AND AppointDate < ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setTime(1, currentTime);
            pst.setDate(2, currentDate);

            result = pst.executeUpdate();
        }

        return result;
    }

    public static boolean checkAppStatus(String appID) throws Exception {
        boolean result = false;
        Time currentTime = Time.valueOf(LocalTime.now());
        Date currentDate = Date.valueOf(LocalDate.now());

        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select a.AppID\n"
                    + "FROM Appointments a\n"
                    + "WHERE a.AppID= ?\n"
                    + "AND a.SlotID IN (SELECT SlotID FROM Slot WHERE ? BETWEEN CONVERT(datetime, StartTime) and CONVERT(datetime, EndTime))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, appID);
            pst.setString(2, currentTime.toString());
//            pst.setTime(3, currentTime);
            ResultSet rs = pst.executeQuery();
            if (rs!=null) {
                if(rs.next()){
                    result = true;
                    return result;
                }
            }
        }

        return result;
    }

    public static ArrayList<Appointments> getDocAppByStatus(String docID, String status) throws Exception {
        ArrayList<Appointments> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT A.AppID, A.CusID, A.BirdID, A.AppointDate, A.SlotID, A.Status, A.Note\n"
                    + "FROM Appointments A\n"
                    + "WHERE A.DocID = ? and Status = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docID);
            pst.setInt(2, Integer.parseInt(status));
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String appID = rs.getString("AppID");
                    String cusID = rs.getString("CusID");
                    String birdID = rs.getString("BirdID");
                    String appointDate = rs.getString("AppointDate");
                    int slotID = rs.getInt("SlotID");
                    int Status = rs.getInt("Status");
                    Appointments app = new Appointments(appID, cusID, docID, birdID, appointDate, slotID, Status);
                    list.add(app);
                }
            }
        }

        return list;
    }

    public static ArrayList<Appointments> getDoctorAppointmentList(String docID, String startday, String endday) throws Exception {
        ArrayList<Appointments> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT A.AppID, A.CusID, A.BirdID, A.AppointDate, A.SlotID, A.Status, A.Note\n"
                    + "FROM Appointments A LEFT JOIN Customers c on A.CusID = c.CusID LEFT JOIN Users u \n"
                    + "on c.UserID = u.UserID LEFT JOIN Birds b on A.BirdID = b.BirdID\n"
                    + "WHERE A.DocID = ? AND (A.AppointDate BETWEEN ? AND ?)  ORDER BY SlotID Asc, AppointDate Asc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docID);
            pst.setString(2, startday);
            pst.setString(3, endday);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String appID = rs.getString("AppID");
                    String cusID = rs.getString("CusID");
                    String birdID = rs.getString("BirdID");
                    String appointDate = rs.getString("AppointDate");
                    int slotID = rs.getInt("SlotID");
                    int status = rs.getInt("Status");
                    Appointments app = new Appointments(appID, cusID, docID, birdID, appointDate, slotID, status);
                    list.add(app);
                }
            }
        }
        return list;
    }

    public static void main(String[] args) throws Exception {
        System.out.println(checkAppStatus("APP-0023"));
    }
}
