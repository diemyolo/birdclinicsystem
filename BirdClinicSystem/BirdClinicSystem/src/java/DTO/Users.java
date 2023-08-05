/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Users {
    public String UserID;
    public String Email;
    public String Password;
    public String Fullname;
    public String Image;
    public String Gender;
    public String Phone;
    public String Address;
    public String BirthDate;
    public int Status;
    public int RoleID;

    public Users() {
    }
    
    public Users(String UserID, String Email, String Password, String Fullname, String Image, String Gender, String Phone, String Address, String BirthDate, int Status, int RoleID) {
        this.UserID = UserID;
        this.Email = Email;
        this.Password = Password;
        this.Fullname = Fullname;
        this.Image = Image;
        this.Gender = Gender;
        this.Phone = Phone;
        this.Address = Address;
        this.BirthDate = BirthDate;
        this.Status = Status;
        this.RoleID = RoleID;
    }

    public Users(String Email, String Password, String Fullname, String Phone) {
        this.Email = Email;
        this.Password = Password;
        this.Fullname = Fullname;
        this.Phone = Phone;
    }

    public Users(String UserID) {
        this.UserID = UserID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getFullname() {
        return Fullname;
    }

    public void setFullname(String Fullname) {
        this.Fullname = Fullname;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getBirthDate() {
        return BirthDate;
    }

    public void setBirthDate(String BirthDate) {
        this.BirthDate = BirthDate;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

    @Override
    public String toString() {
        return "Users{" + "UserID=" + UserID + ", Email=" + Email + ", Password=" + Password + ", Fullname=" + Fullname + ", Image=" + Image + ", Gender=" + Gender + ", Phone=" + Phone + ", Address=" + Address + ", BirthDate=" + BirthDate + ", Status=" + Status + ", RoleID=" + RoleID + '}';
    }
    
    
   
    
}