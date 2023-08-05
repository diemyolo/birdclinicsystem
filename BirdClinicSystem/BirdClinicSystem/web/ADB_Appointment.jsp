<%-- 
    Document   : ADB_HomePage
    Created on : Jul 5, 2023, 2:37:46 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.AppointmentDAO"%>
<%@page import="DTO.AppointmentsForm"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="DashBoardCSS/style.css" />
        <link rel="stylesheet" href="DashBoardCSS/appointment.css" />
        <!--        Pop-UP CSS-->
        <link href="css/PopUpMess.css" rel="stylesheet">
        <!-- Boxicons CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />


    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.admin == null}">
                <c:set var="warning" value="You need to log in as Admin to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
        </c:choose>
        <div class="sidebar">
            <div class="logo-details">              
                <img class="bx bxl-c-plus-plus" src="img/pl 1.png" height="50px" style="margin: 5px;"  alt=""/>
                <span class="logo_name">BirdClinic</span>
            </div>
            <ul class="nav-links">
                <li>
                    <a href="MainController?action=InvoiceList" >
                        <i class="bx bx-grid-alt"></i>
                        <span class="links_name">Dashboard</span>
                    </a>
                </li>
                <span class="dropdown-btn"><i class="fa-regular fa-user" style=" min-width: 60px; margin-left: 6px;font-size: 18px;color: rgba(11, 183, 131, 1); "><span class="links_name" style="margin-left: 22px;font-weight: 400;white-space: nowrap; color: black">Users</span></i></span>
                <span class="dropdown-container">
                    <div class="fadeIn first" style="padding: 10px;">                           
                        <a class="hover_div" href="MainController?action=CustomerList"><i class="fa-solid fa-user-pen " style="margin: 5px; margin-right: 13px; color: black"></i>Customers</a>
                    </div>
                    <div class="fadeIn second" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=StaffList"><i class="fa-solid fa-user-gear" style="margin: 5px; margin-right: 13px; color: black"></i>Staffs</a>
                    </div>
                    <div class="fadeIn third" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=DoctorList"><i class="fa-solid fa-user-doctor fa-lg" style="margin: 5px; margin-right: 16px; ;color: black"></i>Doctors</a>
                    </div>
                </span>
                <li>
                    <a href="MainController?action=AppointmentList" class="active">
                        <i class="fa-regular fa-calendar-days" style="color: #0bb783;"></i>
                        <span class="links_name">Appointment</span>
                    </a>
                </li>
                <li>
                    <a href="ADB_Medicine.jsp">
                        <i class="fa-solid fa-capsules" style="color: #0db783;"></i>
                        <span class="links_name">Medicine</span>
                    </a>
                </li>
                <li>
                    <a href="ADB_Profile.jsp">
                        <i class="fa-regular fa-circle-user"></i>
                        <span class="links_name">My Profile</span>
                    </a>
                </li>


                <li class="log_out">
                    <a href="#LogOut">
                        <i class="bx bx-log-out"></i>
                        <span class="links_name">Log out</span>
                    </a>
                </li>
            </ul>

        </div>
        <section class="home-section">
            <nav style="background: #3ED6A8;" >
                <div class="sidebar-button">
                    <i class="bx bx-menu sidebarBtn" style="cursor: pointer"></i>
                    <span class="dashboard" style="color: white;">Dashboard</span>
                </div>
                <div class="profile-details">
                    <img src="img/user-profile.png" alt="" />
                    <span class="admin_name">${sessionScope.adminname}</span>    
                </div>
            </nav>

            <div class="home-content">
                <div class="sales-boxes">
                    <div class="recent-sales box">
                        <form action="MainController" method="post">
                            <div class="row-cell">
                                <c:set var="totalAppointments" value="0"></c:set>
                                <c:forEach var="list" items="${requestScope.list}">
                                    <c:set var="totalAppointments" value="${totalAppointments + 1}" />
                                </c:forEach>
                                <div class="col-sm-2">
                                    <h4 style="margin:0px;">Appointment</h4>
                                    <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalAppointments} appointments</p>
                                </div>
                                <div class="col-sm-2" style="border-bottom: 1px solid">
                                    <input type="text" name="txtkeyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 10px; border: none; width: 80%">
                                    <button value="AppointmentList" style="border:none; background-color: white; cursor: pointer" name="action">
                                        <svg xmlns="http://www.w3.org/2000/svg"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                        </svg>
                                    </button>
                                </div>
                                <select name="txtsearchby" class="selecttextbox col-sm-2" style="width: 20%; margin-left: 25px">
                                    <option value="appid" ${requestScope.searchby == 'appid' ? 'selected' : ''}>App ID</option>
                                    <option value="cusname" ${requestScope.searchby == 'cusname' ? 'selected' : ''}>Customer Name</option>
                                </select>
                                <div class="col-sm-3" >
                                    <div class="box-shade" style="margin-right: 10px; margin-bottom: 10px;">
                                        <p style="margin: 0px;margin-bottom: -8px; padding: 0px; font-size: 15px; color: #109CF1;">Start with</p>
                                        <input type="Date" class="Date-box" name="txtstartDate" value="${requestScope.startdate}"> 
                                    </div>                      
                                    <div class="box-shade">
                                        <p style="margin: 0px; margin-bottom: -8px; padding: 0px; font-size: 15px; color: #109CF1;">End with</p>
                                        <input type="Date" class="Date-box" name="txtendDate" value="${requestScope.enddate}">
                                    </div> 
                                </div>
                                <div class="col-sm-1">
                                    <div class="form-check cen1">
                                        <input class="form-check-input" style="margin-top: 10px;" type="checkbox" value="pending" id="defaultCheck1" name="txtpending" ${requestScope.Pending == 'pending' ? 'checked' : ''}>
                                        <label class="form-check-label" for="defaultCheck1" style="color:red">
                                            Pending
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" style="margin-top: 10px;"  type="checkbox" value="completed" id="defaultCheck1" name="txtcompleted" ${requestScope.Completed == 'completed' ? 'checked' : ''}>
                                        <label class="form-check-label" for="defaultCheck1" style="color:green">
                                            Completed
                                        </label>
                                    </div>
                                </div>       
                            </div>
                        </form>

                        <table border="1" width="100%" >                                
                            <tbody>
                                <tr class="table-cus">
                                    <th>APPOINTMENT ID</th>
                                    <th>CUSTOMER NAME</th>
                                    <th>DATE & TIME</th>
                                    <th>SERVICES</th>
                                    <th>DOCTOR NAME</th>
                                    <th>STATUS</th>
                                    <th>DETAILS</th>
                                </tr>
                                <c:forEach var="list" items="${requestScope.list}" varStatus="status">
                                    <tr>
                                        <td>${list.getAppID()}</td>
                                        <td>${list.getCustomerName()}</td>
                                        <td style="width: 15%">
                                            <h5 style="margin:0px; font-size: 20px;color:rgba(62, 214, 168, 1);">${list.getDate()}</h5>
                                            <p style="margin:0px; font-size: 17px; color:rgba(201, 202, 202, 1);">${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}</p>
                                        </td>
                                        <td>${list.getServiceName()}</td>
                                        <td>${list.getDoctorName()}</td>
                                        <c:if test="${list.getStatus() eq 1}">
                                            <td><div class="pending"><a>Pending</a></div></td>
                                        </c:if>
                                        <c:if test="${list.getStatus() eq 0}">
                                            <td><div class="completed">Completed</div></td> 
                                        </c:if>
                                        <td style="text-align: center;">
                                            <a class="button" href="#PopUpMess${status.index}">
                                                <i class="fa-solid fa-bars"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>    
                    </div>
                </div>
            </div>
        </section> 
        <!--Pop up Appointment-->
        <!------------------------ POPUP -------------------------->
        <c:forEach var="list" items="${requestScope.list}" varStatus="status">
            <div id="PopUpMess${status.index}" class="modal-container ">
                <div class="form-popup " id="myForm" style="width: 65%; max-width: 1000px">

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
                                <h1 style="margin: 30px auto;">Appointment Form</h1>  
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
                                    <input style="width: 111%;" type="text" value=""  placeholder="${list.getBirdName()}" class="textbox1" readonly>
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Mobile number:</div>
                                    <input style="width: 121%" class="textbox1" type="text" value=""  placeholder="${list.getPhone()}" readonly>
                                </div>                     

                            </div>

                            <div class="row1">
                                <div class="col-sm-2" style="margin-left: 5px;">Address:</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${list.getAddress()}" class="textbox1" readonly>
                            </div>
                            <div class="row1">
                                <div class="col-sm-2">Doctor In Charge:</div>
                                <input style="width: 84%" class="textbox1" type="text" value=""  placeholder="${list.getDoctorName()}" readonly>
                            </div>


                            <div class="row1" style="background-color: white">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Scheduled date:</div>
                                    <input style="width: 130%;" class="textbox1" type="text" value=""  placeholder="${list.getDate()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Slot Time:</div>
                                    <input style="width: 134%;" type="text" value=""  placeholder="${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}" class="textbox1"  readonly>
                                </div>                           
                            </div>
                            <div class="row1">
                                <div class="col-sm-2" style=" padding: 5px; margin-left: 5px;">Service(s):</div>
                                <input style="width: 80%;" type="text" value=""  placeholder="${list.getServiceName()}" class="textbox1" readonly>
                            </div>
                            <c:choose>
                                <c:when test="${not empty list.customerNote}">
                                    <div class="row1">
                                        <div style="width: 20%; padding: 5px; margin-left: 5px;">Customer note:</div>
                                        <input style="width: 79%;" type="text" value="" placeholder="${list.getCustomerNote()}" class="textbox1" readonly>
                                    </div>
                                </c:when>
                            </c:choose>

                        </div>
                    </form> 
                </div>
            </div>
        </c:forEach>
        <!--            // Logout confirm-->
        <div id="LogOut" class="modal-container ">
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
        <script>
            let sidebar = document.querySelector(".sidebar");
            let sidebarBtn = document.querySelector(".sidebarBtn");
            sidebarBtn.onclick = function () {
                sidebar.classList.toggle("active");
                if (sidebar.classList.contains("active")) {
                    sidebarBtn.classList.replace("bx-menu", "bx-menu-alt-right");
                } else
                    sidebarBtn.classList.replace("bx-menu-alt-right", "bx-menu");
            }

            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;
            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        </script>

    </body>
</html>
