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
public class Category {
    public String CateID;
    public int CateName;
    public int CateDescription;

    public Category() {
    }

    public Category(String CateID, int CateName, int CateDescription) {
        this.CateID = CateID;
        this.CateName = CateName;
        this.CateDescription = CateDescription;
    }

    public String getCateID() {
        return CateID;
    }

    public void setCateID(String CateID) {
        this.CateID = CateID;
    }

    public int getCateName() {
        return CateName;
    }

    public void setCateName(int CateName) {
        this.CateName = CateName;
    }

    public int getCateDescription() {
        return CateDescription;
    }

    public void setCateDescription(int CateDescription) {
        this.CateDescription = CateDescription;
    }
    
    
}
