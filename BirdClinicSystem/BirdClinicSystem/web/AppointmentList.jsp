<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.AppointmentDAO"%>
<%@page import="DAO.InvoiceDAO"%>
<%@ page session="true" %>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.AppointmentsForm"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <link href="css/AppointDetail.css" rel="stylesheet">
    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.customer == null}">
                <c:set var="warning" value="You need to log in as Customer to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="headerUser.jsp"/>
            </c:otherwise>
        </c:choose>
        <%@include file="NotificationMess.jsp" %>
        <c:set var="updateStatus" value="${AppointmentDAO.updateAppStatus()}"/>
        <div title="Hello world" class="userprofile">
            <div class="leftprofile">
                <div style="background: url('img/user-background-img.jpg'); height: 120px;"></div>
                <div class="userlogo">
                    <img src="${sessionScope.customer.image == null ? 'img/user-icon.png' : sessionScope.customer.image}"  alt=""/>
                    <!--<label for="input-file" class="change-image-label"><i class="fa-solid fa-pen"></i></label>-->
                </div>
                <form id="profile-form" action="UploadImageServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="email" value="${sessionScope.customer.email}">
                    <input type="file" accept="image/jpeg, image/png, image/jpg" name="file" id="input-file" style="display: none">
                    <input type="submit" value="Save Image" id="choose-image-btn" style="display: none;">
                </form>
                <div class="username">
                    <h1>${sessionScope.customer.fullname}</h1>
                    <p>${sessionScope.customer.getEmail()}</p>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-user"></i>
                    <h1 ><a class="underlineHoverlogin"  href="user-profile">Profile</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-dove"></i>
                    <h1><a class="underlineHoverlogin" href="BirdList.jsp">My Bird</a></h1>
                </div>
                <div class="userprofileoption selected">
                    <i class="fa-solid fa-calendar-day"></i>
                    <h1><a class="underlineHoverlogin" href="MainController?action=CustomerAppointmentList">Appointment</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <h1><a class="underlineHoverlogin" href="#PopUpMess">Log Out</a></h1>
                </div>
            </div>
            <div class="rightprofile">
                <div class="appoint-header">
                    <h1 style="margin-bottom: 20px; flex-grow: 2; font-size: 48px">Appointments</h1>
                    <form action="MainController" method="post" class="mark1" style="border-bottom: 0">
                        <div class="box-shade">
                            <p style="margin: 0px;margin-bottom: -8px; padding: 0px; font-size: 15px;">Start with</p>
                            <input type="Date" class="Date-box" name="txtstartDate" value="${requestScope.startdate}"> 
                        </div>

                        <div class="box-shade">
                            <p style="margin: 0px; margin-bottom: -8px; padding: 0px; font-size: 15px;">End with</p>
                            <input type="Date" class="Date-box" name="txtendDate" value="${requestScope.enddate}">
                        </div> 

                        <button type="submit" placeholder="Sort" value="CustomerAppointmentList" name="action" style="border:none;margin-bottom: 20px; margin-right: 50px; margin-left: 20px; background: white"><i class="fa-solid fa-sort fa-lg" style="color: #000000;"></i></button>
                    </form>
                    <a href="MainController?action=checkBirdAvailable" style="" class="newAppointmentBtn">New Appointment</a>

                </div>

                <table class="profileinformation">
                    <tr class="tableheader">
                        <td>Time</td>
                        <td>Date</td>
                        <td>Bird</td>
                        <td>Service</td>
                        <td>Doctor</td>
                        <td>Status</td>
                        <td></td>
                    </tr>
                    <c:forEach var="list" items="${requestScope.list}" varStatus="status">
                        <tr class="tablerow">
                            <td>${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}</td>
                            <td>${list.getDate()}</td>
                            <td>${list.getBirdName()}</td>
                            <td>${list.getServiceName()}</td>
                            <td>${list.getDoctorName()}</td>
                            <c:if test="${list.getStatus() eq 1}">
                                <td class="pending">   
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
                                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
                                    </svg> 
                                    Pending
                                </td>
                            </c:if>
                            <c:if test="${list.getStatus() eq 0}">
                                <td class="completed">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16">
                                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                    <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
                                    </svg>
                                    Completed  
                                </td>
                            </c:if>
                            <td><a href="#disclaimer${status.index}" ><i class="fa-solid fa-circle-info fa-lg" style="color: #000000;"></i></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <!--------------------------FEEDBACK---------------------------------------->
        <div id="PopUpFeedBack" class="modal-container ">

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
        <!------------------------------------------------------------------------>
        <!------------------------ POPUP -------------------------->
        <c:forEach var="list" items="${requestScope.list}" varStatus="status">
            <div id="disclaimer${status.index}" class="modal-container ">
                <div class="form-popup " id="myForm" style="width: 65%; max-width: 1000px;">

                    <form action="MainController" class="form-container" method="POST" style="width: 100%">
                        <div class="flex-header" style="display: flex; justify-content: flex-end">                  
                            <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                </svg></a>
                        </div>
                        <div class="flex-header">
                            <div class="pic" >
                                <img src="img/pl 1.png" style="height: 75px;margin-right: 10px;" alt=""/>
                                <h1 style="color: black">Appointment Form</h1>  
                            </div>
                        </div>                    
                        <div class="table-row">
                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Customer’s Name:</div>
                                    <input style="width: 141%;" class="textbox1" type="text" value="" placeholder="${list.getCustomerName()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Bird’s Name:</div>
                                    <input style="width: 150%;" type="text" value=""  placeholder="${list.getBirdName()}" class="textbox1" readonly>
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Mobile number:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${list.getPhone()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Address:</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${list.getAddress()}" class="textbox1" readonly>
                            </div>
                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Doctor In Charge:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${list.getDoctorName()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1" style="background-color: white">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Scheduled date:</div>
                                    <input style="width: 141%;" class="textbox1" type="text" value=""  placeholder="${list.getDate()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Slot Time:</div>
                                    <input style="width: 150%;" type="text" value=""  placeholder="${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}" class="textbox1"  readonly>
                                </div>                           
                            </div>
                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Service(s):</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${list.getServiceName()}" class="textbox1" readonly>
                            </div>
                            <c:choose>
                                <c:when test="${not empty list.customerNote}">
                                    <div class="row1">
                                        <div style="width: 20%; padding: 5px; margin-left: 5px;">Customer note:</div>
                                        <input style="width: 79%;" type="text" value="" placeholder="${list.getCustomerNote()}" class="textbox1" readonly>
                                    </div>
                                </c:when>
                            </c:choose>

                            <c:choose>
                                <c:when test="${list.getStatus() eq 0}">
                                    <div>                            
                                        <a href="MainController?action=Go to invoice&AppID=${list.appID}" class="underlineHoverlogin"><input type="button" style="margin-top: 30px; padding: 12px 40px; background-color:#3DC8C8;color: white; font-weight: bold;" value="Invoice" ></a>                           
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="margin-top: 30px;">
                                        <!--<a href="#rescheduleApp">Reschedule</a>-->
                                        <a class="cancelApp" href="MainController?action=cancelFromAppDetail&appID=${list.getAppID()}">Cancel</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </form> 
                </div>
            </div>


            <div id="rescheduleApp">
                <%  LocalDate currentDate = LocalDate.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String formattedDate = currentDate.format(formatter);%>
                <form action="MainController" class="reschedule_form" method="post">
                    <h1>Rescheduling</h1>
                    <h6 style="margin-top: 20px;">Rescheduling from <span>${list.getDate()}</span> at <span>${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}</span> to: </h6>
                    <div class="reschedule_wrapper">
                        <input id="rescheduleDatePicker" type="date" min="<%=formattedDate%>" name="resDate" onchange="functionOnChange(event)"/>
                        <div id="reschedule_slots"></div>
                    </div>
                        <input type="hidden" name
                    <div class="buttons">
                        <button type="submit" name="action" value="rescheduleApp">Reschedule</button>
                        <a href="#" class="btnCancel" style="padding: 5px 10px; background: red; display: block;">Cancel</a>                    
                    </div>
                </form>
            </div>
        </c:forEach>
        <!--                /*--------------------------------------------------------------*/-->
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
        <!--                /*--------------------------------------------------------------*/-->
        <div>
            <c:import url="footer.jsp"/>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script>
                            const inputFile = document.getElementById("input-file");
                            const chooseImageBtn = document.getElementById("choose-image-btn");
                            const updateImageLabel = document.querySelector(".change-image-label");

                            inputFile.addEventListener("change", () => {
                                if (inputFile.files.length > 0) {
                                    chooseImageBtn.style.display = "block";
                                } else {
                                    chooseImageBtn.style.display = "none";
                                }
                            });
                            function functionOnChange(e) {
                                var getDate = e.target.value;
                                $.ajax({
                                    url: 'getAvailableSlotsAjax',
                                    data: {
                                        date: getDate
                                    },
                                    success: function (responseText) {
                                        var res = document.getElementById("reschedule_slots");
                                        res.innerHTML = responseText;
                                    }
                                });
                            }
        </script>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>