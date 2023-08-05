/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author ADMIN
 */
public class Slot {
    private String slotID;
    private String startTime;
    private String endTime;

    public Slot() {
    }

    public Slot(String slotID, String startTime, String endTime) {
        this.slotID = slotID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getSlotID() {
        return slotID;
    }

    public void setSlotID(String slotID) {
        this.slotID = slotID;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Slot{" + "slotID=" + slotID + ", startTime=" + startTime + ", endTime=" + endTime + '}';
    }
    
    
}
