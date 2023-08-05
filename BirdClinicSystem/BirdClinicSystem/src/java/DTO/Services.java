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
public class Services {
    private String ServID;
    private String ServName;
    private float Price;
    private String Serv_img;
    private String Ser_description;

    public Services() {
    }

    public Services(String ServID, String ServName, float Price, String Serv_img, String Ser_description) {
        this.ServID = ServID;
        this.ServName = ServName;
        this.Price = Price;
        this.Serv_img = Serv_img;
        this.Ser_description = Ser_description;
    }

    public String getServID() {
        return ServID;
    }

    public void setServID(String ServID) {
        this.ServID = ServID;
    }

    public String getServName() {
        return ServName;
    }

    public void setServName(String ServName) {
        this.ServName = ServName;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float Price) {
        this.Price = Price;
    }

    public String getServ_img() {
        return Serv_img;
    }

    public void setServ_img(String Serv_img) {
        this.Serv_img = Serv_img;
    }

    public String getSer_description() {
        return Ser_description;
    }

    public void setSer_description(String Ser_description) {
        this.Ser_description = Ser_description;
    }
    
}
