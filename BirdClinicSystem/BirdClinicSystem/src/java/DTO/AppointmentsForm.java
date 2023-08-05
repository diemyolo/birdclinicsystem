/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DTO;

/**
 * 
 * @author ASUS
 */
public class AppointmentsForm {
    private String appID;
    private String customerName;
    private String phone;
    private String address;
    private String startTime;
    private String endTime;
    private String date;
    private String birdName;
    private String species;
    private String serviceName;
    private String doctorName;
    private int status;
    private String customerNote;

    public AppointmentsForm() {
    }

    public AppointmentsForm(String appID, String customerName, String phone, String address, String startTime, String endTime, String date, String birdName, String species, String serviceName, String doctorName, int status, String customerNote) {
        this.appID = appID;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.startTime = startTime;
        this.endTime = endTime;
        this.date = date;
        this.birdName = birdName;
        this.species = species;
        this.serviceName = serviceName;
        this.doctorName = doctorName;
        this.status = status;
        this.customerNote = customerNote;
    }

    public String getAppID() {
        return appID;
    }

    public void setAppID(String appID) {
        this.appID = appID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getBirdName() {
        return birdName;
    }

    public void setBirdName(String birdName) {
        this.birdName = birdName;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCustomerNote() {
        return customerNote;
    }

    public void setCustomerNote(String customerNote) {
        this.customerNote = customerNote;
    }

    @Override
    public String toString() {
        return "AppointmentForm{" + "appID=" + appID + ", customerName=" + customerName + ", phone=" + phone + ", address=" + address + ", startTime=" + startTime + ", endTime=" + endTime + ", date=" + date + ", birdName=" + birdName + ", species=" + species + ", serviceName=" + serviceName + ", doctorName=" + doctorName + ", status=" + status + ", customerNote=" + customerNote + '}';
    }
}
