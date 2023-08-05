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
public class PrescriptionDetail {
    private String presDetailID;
    private String presID;
    private String medID;
    private int quantity;

    public PrescriptionDetail() {
    }

    public PrescriptionDetail(String presDetailID, String presID, String medID, int quantity) {
        this.presDetailID = presDetailID;
        this.presID = presID;
        this.medID = medID;
        this.quantity = quantity;
    }

    public String getPresDetailID() {
        return presDetailID;
    }

    public void setPresDetailID(String presDetailID) {
        this.presDetailID = presDetailID;
    }

    public String getPresID() {
        return presID;
    }

    public void setPresID(String presID) {
        this.presID = presID;
    }

    public String getMedID() {
        return medID;
    }

    public void setMedID(String medID) {
        this.medID = medID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    

    
    
}
