<%-- 
    Document   : header
    Created on : May 28, 2023, 8:58:20 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/StaffHeader.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <link href="css/PopUpMess.css" rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="pic col-md-6" >
                    <img src="img/pl 1.png" style="height: 75px; margin-right: 10px;" alt=""/>
                    <h1>Bird Clinic</h1>
                </div>
                <div class="log-staff col-md-5" >
                    <div class="staff-box"> 
                        <div class="staff-info" >
                            <h3>${sessionScope.doctor.fullname}</h3>
                            <p>${sessionScope.doctor.email}</p>   
                        </div>
                        <img src="${sessionScope.doctor.image == null ? 'img/user-profile.png' : sessionScope.doctor.image}" alt=""/>
                    </div>
                </div>
                <div class="col-md-1 centerlogout" style="display: flex;justify-content: center;align-items: center;">
                    <form method="post">
                        <a href="#PopUpMess">
                            <svg style="margin-right: 30px;" xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">               
                            <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                            <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                            </svg>
                        </a>                                            
                    </form>  
                </div>
            </div>

            <div class="cata-field">
                <c:choose>
                    <c:when test="${empty param.appointment}">
                        <div class="cata-tag">
                            <a class="underlineHoverlogin" href="Doctor_AppointmentList.jsp">
                                <h5>Appointment</h5>
                                <p>Scheduling</p>
                            </a>
                        </div> 
                    </c:when>
                    <c:otherwise>
                        <div class="cata-tag selected">
                            <a class="underlineHoverlogin" href="Doctor_AppointmentList.jsp">
                                <h5>Appointment</h5>
                                <p>Scheduling</p>
                            </a>
                        </div> 
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${empty param.medicine}">
                        <div class="cata-tag">
                            <a class="underlineHoverlogin" href="Doctor_MedicineList.jsp">
                                <h5>Medicine</h5>
                                <p>Pharmacy Information</p>
                            </a>
                        </div>    
                    </c:when>
                    <c:otherwise>
                        <div class="cata-tag selected">
                            <a class="underlineHoverlogin" href="Doctor_MedicineList.jsp">
                                <h5>Medicine</h5>
                                <p>Pharmacy Information</p>
                            </a>
                        </div>    
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${empty param.profile}">
                        <div class="cata-tag">
                            <a class="underlineHoverlogin" href="DoctorProfile.jsp">
                                <h5>Doctor Profile</h5>
                                <p>Personal Information</p>
                            </a>
                        </div>  
                    </c:when>
                    <c:otherwise>
                        <div class="cata-tag selected">
                            <a class="underlineHoverlogin" href="DoctorProfile.jsp">
                                <h5>Doctor Profile</h5>
                                <p>Personal Information</p>
                            </a>
                        </div>  
                    </c:otherwise>
                </c:choose>

        </div>
        <div id="PopUpMess" class="modal-container ">

            <div class="form-popup-header" id="myForm">
                <div class="img-ab" >                                         
                    <div class="pic" >
                        <img src="img/pl 1.png" style="height: 75px;" alt=""/>               
                    </div>
                </div>
                <form action="MainController" class="form-container" method="POST">
                    <div style="margin: 25px; margin-top: 20px; font-size: 24px; font-weight: bold;">
                        Do you want to Log Out?
                    </div>
                    <div style="display: flex; justify-content: center;">
                        <a href="MainController?action=Logout" class="button-con">Confirm</a>
                        <a href="#" class=" button-cancel" style="margin-left: 30px;">Cancel</a>
                    </div>

                </form> 

            </div>
        </div>
    </body>
</html>
