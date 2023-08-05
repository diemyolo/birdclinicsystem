

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/StaffProfile.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.doctor == null}">
                <c:set var="warning" value="You need to log in as Doctor to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="DoctorHeader.jsp?profile=aa"/>
            </c:otherwise>
        </c:choose>

        <div class="container-form" style="position: relative; top: 0px;">
            <div class="form-white">
                <div class="rightprofile">
                    <%@include file="NotificationMess.jsp" %>
                    <h1 style="margin-bottom: 20px; font-size: 48px">Profile</h1>
                    <table class="profileinformation">
                        <tr class="tablerow">
                            <td class="rowheader" >Email</td>
                            <td class="flex-table" style="margin-bottom: 20px;"><input  type="text" value="" name="txtEmail" class="textbox" placeholder="${sessionScope.doctor.email}" readonly></td>
                        </tr>
                        <tr class="tablerow">
                        <form action="MainController" method="POST">
                            <td class="rowheader">Personal Name</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox" placeholder="${sessionScope.doctor.fullname}"></td>
                            <td class="flex-table"><button value="ChangeDoctorProfile" name="action" class="button">Change</button></td></td>
                        </form>
                        </tr>
                        <tr class="tablerow">
                        <form action="MainController" method="POST">
                            <td class="rowheader">Gender</td>
                            <td >
                                <select name="txtGender" class="gender" >
                                    <option value="Male" <c:if test="${sessionScope.doctor.gender == 'Male'}"> selected </c:if> >Male</option>
                                    <option value="Female" <c:if test="${sessionScope.doctor.gender == 'Female'}"> selected </c:if> >Female</option>
                                    <option value="Other" <c:if test="${sessionScope.doctor.gender == 'Other'}"> selected </c:if> >Other</option>
                                </select>
                                </td>                                                                      
                                <td class="flex-table"><button value="ChangeDoctorProfile" name="action" class="button">Change</button></td></td>
                            </form>
                            </tr>

                            <tr class="tablerow">
                            <form action="MainController" method="POST">
                                <td class="rowheader">Password</td>
                                <td>
                                    <span class="textbox">
                                        **********
                                    </span></td>
                                <td class="flex-table">
                                    <input type="hidden" name="roleID" value="${sessionScope.doctor.roleID}">
                                    <button type="submit" value="Go to Change Password" name="action" class="button">Change</button>
                                </td>
                            </form>
                            </tr>
                            <tr class="tablerow">
                            <form action="MainController" method="POST">
                                <td class="rowheader">Phone</td>
                                <td><input type="text" value="" name="txtPhone" class="textbox" placeholder="${sessionScope.doctor.phone}"></td>
                            <td class="flex-table">
                                <button value="ChangeDoctorProfile" name="action" class="button">Change</button>
                            </td>
                        </form>
                        </tr>
                        <tr class="tablerow">
                        <form action="MainController" method="POST">
                            <td class="rowheader">Address</td>
                            <td><input type="text" value="" name="txtAddress" class="textbox" placeholder="${sessionScope.doctor.address}"></td>
                            <td class="flex-table"><button value="ChangeDoctorProfile" name="action" class="button">Change</button></td>
                        </form>
                        </tr>
                        <tr class="tablerow">
                        <form action="MainController" method="POST">
                            <td class="rowheader">Birth Date</td>
                            <td><input type="date" value="${sessionScope.doctor.birthDate}" name="txtBirthDate" style="text-decoration: none;color:grey; border: none; outline: none; margin-left: 50px;"></td>
                            <td class="flex-table"><button value="ChangeDoctorProfile" name="action" class="button">Change</button></td>
                        </form>
                        </tr>
                    </table>

                </div>
            </div>
        </div>       
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "DoctorProfile.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
