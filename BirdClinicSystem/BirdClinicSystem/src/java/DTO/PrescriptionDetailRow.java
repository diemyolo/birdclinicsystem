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
public class PrescriptionDetailRow {
    private String medicineName;
    private int quantity;
    private float medicinePrice;

    public PrescriptionDetailRow() {
    }

    public PrescriptionDetailRow(String medicineName, int quantity, float medicinePrice) {
        this.medicineName = medicineName;
        this.quantity = quantity;
        this.medicinePrice = medicinePrice;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getMedicinePrice() {
        return medicinePrice;
    }

    public void setMedicinePrice(float medicinePrice) {
        this.medicinePrice = medicinePrice;
    }
    
    
}
