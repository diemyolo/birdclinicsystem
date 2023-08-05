/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author Admin
 */
public class Appointments {
    private String AppID;
    private String CusID;
    private String DocID;
    private String BirdID;
    private String AppointDate;
    private int SlotID;
    private int Status;
    
    private String Services;

    public Appointments() {
    }
    //t fix lai het nha

    public Appointments(String AppID, String CusID, String DocID, String BirdID, String AppointDate, int SlotID, int Status, String Services) {
        this.AppID = AppID;
        this.CusID = CusID;
        this.DocID = DocID;
        this.BirdID = BirdID;
        this.AppointDate = AppointDate;
        this.SlotID = SlotID;
        this.Status = Status;
        this.Services = Services;
    }
    
    public Appointments(String AppID, String CusID, String DocID, String BirdID, String AppointDate, int SlotID, int Status) {
        this.AppID = AppID;
        this.CusID = CusID;
        this.DocID = DocID;
        this.BirdID = BirdID;
        this.AppointDate = AppointDate;
        this.SlotID = SlotID;
        this.Status = Status;
    }

    public String getAppID() {
        return AppID;
    }

    public void setAppID(String AppID) {
        this.AppID = AppID;
    }

    public String getCusID() {
        return CusID;
    }

    public void setCusID(String CusID) {
        this.CusID = CusID;
    }

    public String getDocID() {
        return DocID;
    }

    public void setDocID(String DocID) {
        this.DocID = DocID;
    }

    public String getBirdID() {
        return BirdID;
    }

    public void setBirdID(String BirdID) {
        this.BirdID = BirdID;
    }

    public String getAppointDate() {
        return AppointDate;
    }

    public void setAppointDate(String AppointDate) {
        this.AppointDate = AppointDate;
    }

    public int getSlotID() {
        return SlotID;
    }

    public void setSlotID(int SlotID) {
        this.SlotID = SlotID;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public String getServices() {
        return Services;
    }

    public void setServices(String Services) {
        this.Services = Services;
    }
    
    
}
