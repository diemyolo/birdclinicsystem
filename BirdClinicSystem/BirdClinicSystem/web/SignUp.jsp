<%-- 
Document   : sign_up
Created on : Apr 23, 2023, 2:58:10 PM
Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet"href="css/Login.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <title>Sign Up</title>

    </head>
    <body>
        <div class="wrapper-sign-up fadeInDown" >

            <div id="formContent1">
                <div class="fadeIn first cen1" style="margin: 5px auto">                   
                    <h4 style="margin: 5px 163px; font-size: 30px; text-align: center">CREATE ACCOUNT</h4>
                    <br>
                </div>
                <div class="form-con">
                    <form action="MainController" method="POST">                         
                        <input type="text" name="txtEmail" value="${requestScope.email}" placeholder="Email"/>
                        <div class="remind fadeIn second">
                            ${requestScope.emailError}           
                        </div>                                                    
                        <input type="text" name="txtFullname" value="${requestScope.fullname}" placeholder="Full Name" />
                        <div class="remind fadeIn second">
                            ${requestScope.fullnameError}              
                        </div>
                        <select name="txtGender" class="selecttextbox gender">
                            <option style="display: none" disabled selected>Gender</option>
                            <option value="Male" <c:if test="${requestScope.gender == 'Male'}"> selected </c:if>>Male</option>
                            <option value="Female" <c:if test="${requestScope.gender == 'Female'}"> selected </c:if> >Female</option>
                            <option value="Other" <c:if test="${requestScope.gender == 'Other'}"> selected </c:if> >Other</option>
                            </select>
                            <div class="remind fadeIn second">
                            ${requestScope.genderError}
                        </div>
                        <input type="text" name="txtAddress" value="${requestScope.address}"placeholder="Address" /><br/>
                        <div class="remind fadeIn second">
                            ${requestScope.addressError}
                        </div> 
                        <input type="text" name="txtPhoneNumber" value="${requestScope.phone}" placeholder="Phone Number"/><br/>
                        <div class="remind fadeIn second">
                            ${requestScope.phoneError}
                        </div>
                        <input type="password" name="txtPassword" value="${requestScope.password}" placeholder="Password..."/><br/>
                        <div class="remind fadeIn second">
                            ${requestScope.passwordError}             
                        </div>
                        <input type="password" name="txtConfirm" value="${requestScope.confirm}" placeholder="Confirm Password:" /><br/>
                        <div class="remind fadeIn second">
                            ${requestScope.confirmError}              
                        </div>
                        <input type="hidden" name="action" value="Signup" />
                        <input type="submit" class="fadeIn second button " value="Sign Up" />
                    </form> 
                    <div class="goback-button">
                        <span style="margin-right: 5px">Already have an account</span> <a href="login">Log in</a> <span style="margin-left: 5px">here</span> 
                    </div>
                </div>

            </div>
        </div>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "SignUp.jsp");
            }
        </script>
    </body>
</html>
