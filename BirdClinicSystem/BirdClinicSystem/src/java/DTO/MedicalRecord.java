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
public class MedicalRecord {
    private String medRecordID;
    private String birdID;
    private String appID;
    private String symptoms;
    private String Diagnosis;
    private String treatment;

    public MedicalRecord() {
    }

    public MedicalRecord(String medRecordID, String birdID, String appID, String symptoms, String Diagnosis, String treatment) {
        this.medRecordID = medRecordID;
        this.birdID = birdID;
        this.appID = appID;
        this.symptoms = symptoms;
        this.Diagnosis = Diagnosis;
        this.treatment = treatment;
    }

    public String getMedRecordID() {
        return medRecordID;
    }

    public void setMedRecordID(String medRecordID) {
        this.medRecordID = medRecordID;
    }

    public String getBirdID() {
        return birdID;
    }

    public void setBirdID(String birdID) {
        this.birdID = birdID;
    }

    public String getAppID() {
        return appID;
    }

    public void setAppID(String appID) {
        this.appID = appID;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptons(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return Diagnosis;
    }

    public void setDiagnosis(String Diagnosis) {
        this.Diagnosis = Diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }
    
    
}
