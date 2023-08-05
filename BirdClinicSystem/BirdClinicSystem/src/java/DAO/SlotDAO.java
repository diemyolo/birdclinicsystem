/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Slot;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SlotDAO {

    public static List<Slot> getSlotList(String doctorID, String appointmentDate) throws Exception {
        List<Slot> slotList = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select Slot.SlotID, Slot.StartTime, Slot.EndTime from (Appointments join Doctors on Appointments.DocID = Doctors.DocID) \n"
                    + "join Slot on Appointments.SlotID = Slot.SlotID\n"
                    + "where Doctors.DocID = ?\n"
                    + "and Appointments.AppointDate = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, doctorID);
            ps.setString(2, appointmentDate);

            ResultSet rs = ps.executeQuery();

            while (rs != null && rs.next()) {
                String slotID = rs.getString("SlotID");
                String startTime = rs.getString("StartTime");
                String endTime = rs.getString("EndTime");

                Slot slot = new Slot(slotID, startTime, endTime);
                slotList.add(slot);
            }
            cn.close();
        }
        return slotList;
    }

    public static Slot getSlotByAppointmentID(String appointmentID) throws Exception {
        Slot slot = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select Slot.SlotID, Slot.StartTime, Slot.EndTime\n"
                    + "from  Appointments join Slot on Appointments.SlotID = Slot.SlotID\n"
                    + "where Appointments.AppID = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, appointmentID);

            ResultSet rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                String slotID = rs.getString("SlotID");
                String startTime = rs.getString("StartTime");
                String endTime = rs.getString("EndTime");

                slot = new Slot(slotID, startTime, endTime);
            }

            cn.close();
        }
        return slot;
    }

    public static Slot getSlotBySlotID(String slotID) throws Exception {
        Slot slot = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select Slot.SlotID, Slot.StartTime, Slot.EndTime\n"
                    + "from Slot\n"
                    + "where SlotID = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, slotID);

            ResultSet rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                String startTime = rs.getString("StartTime");
                String endTime = rs.getString("EndTime");

                slot = new Slot(slotID, startTime, endTime);
            }

            cn.close();
        }
        return slot;
    }

    public static ArrayList<Slot> getAllSlot() throws Exception {
        ArrayList<Slot> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select Slot.SlotID, Slot.StartTime, Slot.EndTime\n"
                    + "from Slot";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String slotID = rs.getString("SlotID");
                    String startTime = rs.getString("StartTime");
                    String endTime = rs.getString("EndTime");
                    Slot slot = new Slot(slotID, startTime, endTime);
                    list.add(slot);
                }
            }
            cn.close();
        }
        return list;
    }

}
