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
public class Medicine {
    public String MedID;
    public String MedName;
    public float MedPrice;
    public String MedDescription;
    public String MedType;
    public int RemainingQuantity;
    public String DrugUse;
    public String SideEffect;
    public String Composition;
    public String MedCategoryID;
    //Prescription
    public int Quantity;
    public String PD;
    public String usage;
    public Medicine() {
    }
    

    public Medicine(String MedID, String MedName, float MedPrice, String MedDescription, String MedType, int RemainingQuantity, String DrugUse, String SideEffect, String Composition, String MedCateID) {
        this.MedID = MedID;
        this.MedName = MedName;
        this.MedPrice = MedPrice;
        this.MedDescription = MedDescription;
        this.MedType = MedType;
        this.RemainingQuantity = RemainingQuantity;
        this.DrugUse = DrugUse;
        this.SideEffect = SideEffect;
        this.Composition = Composition;
        this.MedCategoryID = MedCateID;
    }
    //Prescription
    public Medicine(String MedID, String MedName, float MedPrice, String MedDescription, int RemainingQuantity) {
        this.MedID = MedID;
        this.MedName = MedName;
        this.MedPrice = MedPrice;
        this.MedDescription = MedDescription;
        this.RemainingQuantity = RemainingQuantity;
    }
    
    public Medicine(String PD,String MedID, String MedName, float MedPrice, int Quantity, String MedDescription, String usage) {
        this.PD = PD;
        this.MedID = MedID;
        this.MedName = MedName;
        this.MedPrice = MedPrice;
        this.Quantity = Quantity;
        this.MedDescription = MedDescription;     
        this.usage = usage;
    }
    
    public String getMedID() {
        return MedID;
    }

    public void setMedID(String MedID) {
        this.MedID = MedID;
    }

    public String getMedName() {
        return MedName;
    }

    public void setMedName(String MedName) {
        this.MedName = MedName;
    }

    public float getMedPrice() {
        return MedPrice;
    }

    public void setMedPrice(float MedPrice) {
        this.MedPrice = MedPrice;
    }

    public String getMedDescription() {
        return MedDescription;
    }

    public void setMedDescription(String MedDescription) {
        this.MedDescription = MedDescription;
    }

    public String getMedType() {
        return MedType;
    }

    public void setMedType(String MedType) {
        this.MedType = MedType;
    }

    public int getRemainingQuantity() {
        return RemainingQuantity;
    }

    public void setRemainingQuantity(int RemainingQuantity) {
        this.RemainingQuantity = RemainingQuantity;
    }

    public String getDrugUse() {
        return DrugUse;
    }

    public void setDrugUse(String DrugUse) {
        this.DrugUse = DrugUse;
    }

    public String getSideEffect() {
        return SideEffect;
    }

    public void setSideEffect(String SideEffect) {
        this.SideEffect = SideEffect;
    }

    public String getComposition() {
        return Composition;
    }

    public void setComposition(String Composition) {
        this.Composition = Composition;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public String getPD() {
        return PD;
    }

    public void setPD(String PD) {
        this.PD = PD;
    }

    public String getUsage() {
        return usage;
    }

    public void setUsage(String usage) {
        this.usage = usage;
    }

    public String getMedCategoryID() {
        return MedCategoryID;
    }

    public void setMedCategoryID(String MedCategoryID) {
        this.MedCategoryID = MedCategoryID;
    }
    
    
    
}
