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
public class Feedback {
    private String fedID;
    private String appID;
    private String cusID;
    private int rating;
    private String description;

    public Feedback() {
    }

    public Feedback(String fedID, String appID, String cusID, int rating, String description) {
        this.fedID = fedID;
        this.appID = appID;
        this.cusID = cusID;
        this.rating = rating;
        this.description = description;
    }

    public String getFedID() {
        return fedID;
    }

    public void setFedID(String fedID) {
        this.fedID = fedID;
    }

    public String getAppID() {
        return appID;
    }

    public void setAppID(String appID) {
        this.appID = appID;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
