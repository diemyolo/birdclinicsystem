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
public class Invoice {
    private String invoiceID;
    private String appointmentID;
    private String prescriptionID;
    private float totalMoney;
    private int paid;

    public Invoice(String invoiceID, String appointmentID, String prescriptionID, float totalMoney, int paid) {
        this.invoiceID = invoiceID;
        this.appointmentID = appointmentID;
        this.prescriptionID = prescriptionID;
        this.totalMoney = totalMoney;
        this.paid = paid;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public String getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(String appointmentID) {
        this.appointmentID = appointmentID;
    }

    public String getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(String prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public int getPaid() {
        return paid;
    }

    public void setPaid(int paid) {
        this.paid = paid;
    }

    public Invoice() {
    }

    
    
    
}
