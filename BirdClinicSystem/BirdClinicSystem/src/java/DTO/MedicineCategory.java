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
public class MedicineCategory {
    public String MedCateID;
    public String MedCateName;

    public MedicineCategory() {
    }

    public MedicineCategory(String MedCateID, String MedCateName) {
        this.MedCateID = MedCateID;
        this.MedCateName = MedCateName;
    }

    public String getMedCateID() {
        return MedCateID;
    }

    public void setMedCateID(String MedCateID) {
        this.MedCateID = MedCateID;
    }

    public String getMedCateName() {
        return MedCateName;
    }

    public void setMedCateName(String MedCateName) {
        this.MedCateName = MedCateName;
    }

    
}
