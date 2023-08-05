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
public class Prescription {
    private String presID;
    private String docID;
    private String usage;
    private String medRecordID;
    //other fields
    //shown details
    private String date;
    private String docName;
    
    //pres detail
    private String medID;
    private String medPrice;
    private String quantity;

    public Prescription(String presID, String docID, String usage, String medRecordID, String date) {
        this.presID = presID;
        this.docID = docID;
        this.usage = usage;
        this.medRecordID = medRecordID;
        this.date = date;
    }

    public String getPresID() {
        return presID;
    }

    public void setPresID(String presID) {
        this.presID = presID;
    }

    public String getDocID() {
        return docID;
    }

    public void setDocID(String docID) {
        this.docID = docID;
    }

    public String getUsage() {
        return usage;
    }

    public void setUsage(String usage) {
        this.usage = usage;
    }

    public String getMedRecordID() {
        return medRecordID;
    }

    public void setMedRecordID(String medRecordID) {
        this.medRecordID = medRecordID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDocName() {
        return docName;
    }

    public void setDocName(String docName) {
        this.docName = docName;
    }
    
    
    
    
}
