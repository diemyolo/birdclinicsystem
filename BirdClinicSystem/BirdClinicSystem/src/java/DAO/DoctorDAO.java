/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Appointments;
import DTO.Doctor;
import DTO.Users;
import Utils.DBUtils;
import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class DoctorDAO {

    public static void addDoctor(Users user) {
        String userID = user.getUserID();

        Connection cn = null;
        int kq = 0;
        boolean trig = false;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Doctors (UserID) \n"
                        + "VALUES(?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userID);

                kq = pst.executeUpdate();
                if (kq == 1) {
                    trig = true;
                }
            }

        } catch (Exception e) {

        }
    }

    public static ArrayList<Doctor> getDoctorList() throws Exception {
        ArrayList<Doctor> listDoctor = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select d.DocID as 'DocID', d.Salary as 'Salary', d.Doc_description as 'Doc_description', d.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Doctors d left join dbo.Users u on d.UserID = u.UserID";
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(sql);
            if (table != null) {
                while (table.next()) {
                    String docId = table.getString("DocID");
                    int salary = table.getInt("Salary");
                    String docDes = table.getString("Doc_description");
                    String userid = table.getString("UserID");
                    String email = table.getString("Email");
                    String password = table.getString("Password");
                    String fullName = table.getString("Fullname");
                    String img = table.getString("Img");
                    String gender = table.getString("Gender");
                    String phone = table.getString("Phone");
                    String address = table.getString("Address");
                    String birthDate = table.getString("BirthDate");
                    int status = table.getInt("Status");
                    int RoleID = table.getInt("RoleID");
                    Doctor doctor = new Doctor(docId, salary, docDes, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listDoctor.add(doctor);
                }
            }
            cn.close();
        }
        return listDoctor;
    }

    public static ArrayList<Doctor> getAvailableDoctorIDList(int slot, int date, int month, int year) throws Exception {
        ArrayList<Doctor> listDoctor = new ArrayList<>();

        //set up calen
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, date);
        String[] weekDays = {"", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
        int currentWeekDay = calendar.get(Calendar.DAY_OF_WEEK);
        String myWeekDay = weekDays[currentWeekDay];
        String appointDate = year + "-" + (month + 1) + "-" + date;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT D.DocID as 'DocID', D.Salary as 'Salary', D.Doc_description as 'DocDes'\n"
                    + "FROM Doctors D\n"
                    + "INNER JOIN DoctorShift DS ON D.DocID = DS.DocID\n"
                    + "INNER JOIN Shift S ON DS.ShiftID = S.ShiftID\n"
                    + "WHERE S.ShiftDate = ? AND S.SlotID = ? AND DS.Status = 1\n"
                    + "    AND D.DocID NOT IN (\n"
                    + "        SELECT A.DocID\n"
                    + "        FROM Appointments A\n"
                    + "        WHERE A.SlotID = ? AND A.AppointDate = ?\n"
                    + ")";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, myWeekDay);
            pst.setInt(2, slot);
            pst.setInt(3, slot);
            pst.setString(4, appointDate);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String DocID = rs.getString("DocID");
                    int Salary = rs.getInt("Salary");
                    String DocDes = rs.getString("DocDes");
                    Doctor doctor = new Doctor(DocID, Salary, DocDes);
                    listDoctor.add(doctor);
                }
            }

            cn.close();
        }

        return listDoctor;
    }

    public static String getDoctorNameByID(String docID) throws Exception {
        String docName = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT Users.Fullname as 'Fullname'\n"
                    + "FROM Doctors left join Users on Doctors.UserID = Users.UserID\n"
                    + "WHERE DocID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    docName = rs.getString("Fullname");
                }
            }
        }
        return docName;
    }
    public static ArrayList<Doctor> getDoctorListByID(String doctorID) throws Exception {
        ArrayList<Doctor> listDoctor = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select d.DocID as 'DocID', d.Salary as 'Salary', d.Doc_description as 'Doc_description', d.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Doctors d left join dbo.Users u on d.UserID = u.UserID where d.DocID like ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, "%" + doctorID + "%");

            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String docId = rs.getString("DocID");
                    int salary = rs.getInt("Salary");
                    String docDes = rs.getString("Doc_description");
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
                    Doctor doctor = new Doctor(docId, salary, docDes, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listDoctor.add(doctor);
                }
            }
            cn.close();
        }
        return listDoctor;
    }

    public static ArrayList<Doctor> getDoctorListByName(String doctorName) throws Exception {
        ArrayList<Doctor> listDoctor = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select d.DocID as 'DocID', d.Salary as 'Salary', d.Doc_description as 'Doc_description', d.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Doctors d left join dbo.Users u on d.UserID = u.UserID where u.Fullname like ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, "%" + doctorName + "%");

            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String docId = rs.getString("DocID");
                    int salary = rs.getInt("Salary");
                    String docDes = rs.getString("Doc_description");
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
                    Doctor doctor = new Doctor(docId, salary, docDes, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listDoctor.add(doctor);
                }
            }
            cn.close();
        }
        return listDoctor;
    }

    public static List<String> getAppointmentDateList(String doctorID, String startTime, String endTime) throws Exception {
        ArrayList<String> appointmentDateList = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();

        if (cn != null) {
            String sql = "select distinct Appointments.AppointDate\n"
                    + "	from \n"
                    + "	Users join \n"
                    + "	(Doctors join \n"
                    + "	(Appointments join Slot on Appointments.SlotID = Slot.SlotID) \n"
                    + "	on Doctors.DocID = Appointments.DocID)\n"
                    + "	on Users.UserID = Doctors.UserID\n"
                    + "	where Doctors.DocID = ?\n"
                    + "	and Appointments.AppointDate between ? and ?\n";

            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, doctorID);
            ps.setString(2, startTime);
            ps.setString(3, endTime);

            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String appointmentDate = rs.getString("AppointDate");
                    appointmentDateList.add(appointmentDate);
                }
            }
            cn.close();
        }
        return appointmentDateList;
    }

    public static List<Appointments> getAppointmentList(String doctorID, String startTime, String endTime) throws Exception {
        ArrayList<Appointments> appointmentList = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();

        if (cn != null) {
            String sql = "select Appointments.AppID, Appointments.CusID, Appointments.DocID, \n"
                    + "Appointments.BirdID, Appointments.AppointDate, Appointments.SlotID, Appointments.status\n"
                    + "from \n"
                    + "Users join \n"
                    + "(Doctors join \n"
                    + "(Appointments join Slot on Appointments.SlotID = Slot.SlotID) \n"
                    + "on Doctors.DocID = Appointments.DocID)\n"
                    + "on Users.UserID = Doctors.UserID\n"
                    + "\n"
                    + "where Doctors.DocID = ? \n"
                    + "and Appointments.AppointDate between ? and ? \n";

            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, doctorID);
            ps.setString(2, startTime);
            ps.setString(3, endTime);

            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String AppID = rs.getString("AppID");
                    String CusID = rs.getString("CusID");
                    String BirdID = rs.getString("BirdID");
                    String AppointDate = rs.getString("AppointDate");
                    int SlotID = rs.getInt("SlotID");
                    int Status = rs.getInt("status");

                    Appointments appointments = new Appointments(AppID, CusID, doctorID, BirdID, AppointDate, SlotID, Status);
                    appointmentList.add(appointments);
                }
            }
            cn.close();
        }
        return appointmentList;
    }

    public static ArrayList<Doctor> getPaginatedDoctors(int pageNumber, int doctorPerPage, ArrayList<Doctor> doctorList) throws Exception {
        ArrayList<Doctor> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        int start = (pageNumber - 1) * doctorPerPage;
        int end = start + doctorPerPage - 1;
        if (end > doctorList.size() || end == doctorList.size()) {
            end = doctorList.size() - 1;
        }
        for (int i = start; i <= end; i++) {
            list.add(doctorList.get(i));
        }
        return list;
    }

    public static Doctor getDoctorWithUserID(String userID) throws Exception {
        Doctor doc = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT DocID, u.Fullname, d.Salary, d.Doc_description\n"
                    + "FROM Doctors d left join Users u on d.UserID = u.UserID\n"
                    + "WHERE d.UserID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String docID = rs.getString("DocID");
                String fullName = rs.getString("Fullname");
                int Salary = rs.getInt("Salary");
                String docDes = rs.getString("Doc_description");
                doc = new Doctor(docID, fullName, Salary, docDes);
            }
        }

        return doc;
    }

    public static ArrayList<Doctor> searchDoctor(String keyword, String searchby, String Status) throws Exception {
        ArrayList<Doctor> listDoctor = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Select d.DocID as 'DocID', d.Salary as 'Salary', d.Doc_description as 'Doc_description', d.UserID as 'UserID', u.Email as 'Email', u.Password as 'Password', u.Fullname as 'Fullname', u.Img as 'Img', u.Gender as 'Gender', u.Phone as 'Phone', u.Address as 'Address', u.BirthDate as 'BirthDate', u.Status, u.RoleID as 'RoleID'\n"
                    + "from dbo.Doctors d left join dbo.Users u on d.UserID = u.UserID";
            if (searchby.equalsIgnoreCase("docid")) {
                sql = sql + " where DocID like ?";
            } else if (searchby.equalsIgnoreCase("docmail")) {
                sql = sql + " where Email like ?";
            } else if (searchby.equalsIgnoreCase("docname")) {
                sql = sql + " where Fullname like ?";
            } else if (searchby.equalsIgnoreCase("docphone")) {
                sql = sql + " where Phone like ?";
            }
            if (Status.equalsIgnoreCase("active")) {
                sql = sql + " and Status = 0";
            } else if (Status.equalsIgnoreCase("suspended")) {
                sql = sql + " and Status = 1";
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String docId = rs.getString("DocID");
                    int salary = rs.getInt("Salary");
                    String docDes = rs.getString("Doc_description");
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
                    Doctor doctor = new Doctor(docId, salary, docDes, userid, email, password, fullName, img, gender, phone, address, birthDate, status, RoleID);
                    listDoctor.add(doctor);
                }
            }
            cn.close();
        }
        return listDoctor;
    }
    public static Doctor getDoctorByDocID(String docid) throws Exception{
        Doctor doc = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "SELECT DocID, u.Fullname, d.Salary, d.Doc_description\n"
                    + "FROM Doctors d left join Users u on d.UserID = u.UserID\n"
                    + "WHERE DocID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, docid);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String docID = rs.getString("DocID");
                String fullName = rs.getString("Fullname");
                int Salary = rs.getInt("Salary");
                String docDes = rs.getString("Doc_description");
                doc = new Doctor(docID, fullName, Salary, docDes);
            }
        }
        return doc;
    }
    public static boolean updateDoctorSalary(String docid, int salary) throws Exception{
        Boolean result = false;
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "Update Doctors set Salary = ? where DocID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, salary);
            pst.setString(2, docid);
            kq = pst.executeUpdate();
            if (kq == 1) {
                result = true;
            }
            cn.close();
        }
        return result;
    }
    public static void main(String[] args) throws Exception {
        System.out.println(updateDoctorSalary("DR-0001", 20));
        System.out.println(getDoctorByDocID("DR-0001").getSalary());
    }
}
