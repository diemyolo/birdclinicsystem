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
public class Birds extends Customers {
    public String BirdID;
    public String Bird_type;
    public String Bird_name;
    public String Bird_img;
    public String Age_cate;
    public String Habit;
    public String Personal_note;
    public int weight;
    public int Status;

    public Birds() {
    }   
    
    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, int weight, String Personal_note) {
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.weight = weight;
        this.Personal_note = Personal_note;
    }

    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, String Personal_note, int Status) {
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.Personal_note = Personal_note;
        this.Status = Status;
    }

    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, String Personal_note, int Status, String CusID) {
        super(CusID);
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.Personal_note = Personal_note;
        this.Status = Status;
    }

    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, String Personal_note, int Status, String CusID, String UserID) {
        super(CusID, UserID);
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.Personal_note = Personal_note;
        this.Status = Status;
    }

    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, String Personal_note, int Status, String CusID, String UserID, String Email, String Password, String Fullname, String Image, String Gender, String Phone, String Address, String BirthDate, int CustomerStatus, int RoleID) {
        super(CusID, UserID, Email, Password, Fullname, Image, Gender, Phone, Address, BirthDate, CustomerStatus, RoleID);
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.Personal_note = Personal_note;
        this.Status = Status;
    }

    public Birds(String BirdID, String Bird_type, String Bird_name, String Bird_img, String Age_cate, String Habit, String Personal_note, int Status, String CusID, String Email, String Password, String Fullname, String Phone) {
        super(CusID, Email, Password, Fullname, Phone);
        this.BirdID = BirdID;
        this.Bird_type = Bird_type;
        this.Bird_name = Bird_name;
        this.Bird_img = Bird_img;
        this.Age_cate = Age_cate;
        this.Habit = Habit;
        this.Personal_note = Personal_note;
        this.Status = Status;
    }

    public String getBirdID() {
        return BirdID;
    }

    public String getBird_type() {
        return Bird_type;
    }

    public String getBird_name() {
        return Bird_name;
    }

    public String getBird_img() {
        return Bird_img;
    }

    public String getAge_cate() {
        return Age_cate;
    }

    public String getHabit() {
        return Habit;
    }

    public String getPersonal_note() {
        return Personal_note;
    }

    public int getStatus() {
        return Status;
    }

    public String getCusID() {
        return CusID;
    }

    public String getUserID() {
        return UserID;
    }

    public String getEmail() {
        return Email;
    }

    public String getPassword() {
        return Password;
    }

    public String getFullname() {
        return Fullname;
    }

    public String getImage() {
        return Image;
    }

    public String getGender() {
        return Gender;
    }

    public String getPhone() {
        return Phone;
    }

    public String getAddress() {
        return Address;
    }

    public String getBirthDate() {
        return BirthDate;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setBirdID(String BirdID) {
        this.BirdID = BirdID;
    }

    public void setBird_type(String Bird_type) {
        this.Bird_type = Bird_type;
    }

    public void setBird_name(String Bird_name) {
        this.Bird_name = Bird_name;
    }

    public void setBird_img(String Bird_img) {
        this.Bird_img = Bird_img;
    }

    public void setAge_cate(String Age_cate) {
        this.Age_cate = Age_cate;
    }

    public void setHabit(String Habit) {
        this.Habit = Habit;
    }

    public void setPersonal_note(String Personal_note) {
        this.Personal_note = Personal_note;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }    

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
    
    
    
}
