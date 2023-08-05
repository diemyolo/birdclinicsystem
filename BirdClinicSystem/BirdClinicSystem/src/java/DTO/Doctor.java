/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Doctor extends Users{
    private String DocID;
    private int Salary;
    private String DocDes;

    public Doctor() {
    }

    public Doctor(String DocID, int Salary, String DocDes) {
        this.DocID = DocID;
        this.Salary = Salary;
        this.DocDes = DocDes;
    }

    public Doctor(String DocID, String Fullname, int Salary, String DocDes) {
        super(Fullname);
        this.DocID = DocID;
        this.Salary = Salary;
        this.DocDes = DocDes;
    }

    public Doctor(String DocID, String Fullname)
    {
        super(Fullname);
        this.DocID = DocID;
    }

    public Doctor(String DocID, int Salary, String DocDes, String UserID, String Email, String Password, String Fullname, String Image, String Gender, String Phone, String Address, String BirthDate, int Status, int RoleID) {
        super(UserID, Email, Password, Fullname, Image, Gender, Phone, Address, BirthDate, Status, RoleID);
        this.DocID = DocID;
        this.Salary = Salary;
        this.DocDes = DocDes;
    }

    public Doctor(String DocID, int Salary, String DocDes, String Email, String Password, String Fullname, String Phone) {
        super(Email, Password, Fullname, Phone);
        this.DocID = DocID;
        this.Salary = Salary;
        this.DocDes = DocDes;
    }

    public String getDocID() {
        return DocID;
    }

    public void setDocID(String DocID) {
        this.DocID = DocID;
    }

    public int getSalary() {
        return Salary;
    }

    public void setSalary(int Salary) {
        this.Salary = Salary;
    }

    public String getDocDes() {
        return DocDes;
    }

    public void setDocDes(String DocDes) {
        this.DocDes = DocDes;
    }

    @Override
    public String getUserID() {
        return UserID;
    }

    @Override
    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    @Override
    public String getEmail() {
        return Email;
    }

    @Override
    public void setEmail(String Email) {
        this.Email = Email;
    }

    @Override
    public String getPassword() {
        return Password;
    }

    @Override
    public void setPassword(String Password) {
        this.Password = Password;
    }

    @Override
    public String getFullname() {
        return Fullname;
    }

    @Override
    public void setFullname(String Fullname) {
        this.Fullname = Fullname;
    }

    @Override
    public String getImage() {
        return Image;
    }

    @Override
    public void setImage(String Image) {
        this.Image = Image;
    }

    @Override
    public String getGender() {
        return Gender;
    }

    @Override
    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    @Override
    public String getPhone() {
        return Phone;
    }

    @Override
    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    @Override
    public String getAddress() {
        return Address;
    }

    @Override
    public void setAddress(String Address) {
        this.Address = Address;
    }

    @Override
    public String getBirthDate() {
        return BirthDate;
    }

    @Override
    public void setBirthDate(String BirthDate) {
        this.BirthDate = BirthDate;
    }
    
    @Override
    public int getStatus() {
        return Status;
    }

    @Override
    public void setStatus(int Status) {
        this.Status = Status;
    }

    @Override
    public int getRoleID() {
        return RoleID;
    }

    @Override
    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    } 
}
