/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Shift;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class ShiftDAO {
    public static ArrayList<Shift> getAllShift()
    {
        ArrayList<Shift> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT ShiftID, ShiftDate, SlotID FROM Shift";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String shiftID = rs.getString("ShiftID");
                        String shiftDate = rs.getString("ShiftDate");
                        String slotID = rs.getString("SlotID");
                        Shift shift = new Shift(shiftID, shiftDate, slotID);
                        list.add(shift);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
