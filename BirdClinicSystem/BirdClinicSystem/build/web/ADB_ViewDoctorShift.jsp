<%-- 
    Document   : ADB_ViewDoctrShift
    Created on : Jul 28, 2023, 12:16:52 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.DoctorDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <title>JSP Page</title>
        <link href="style/ViewSchedule.css" rel="stylesheet">
        <link rel="stylesheet" href="DashBoardCSS/style.css" />
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
                    <div class="fadeIn second" style="padding: 10px; background: #95EBD1;">
                        <a class="hover_div" href="MainController?action=StaffList"><i class="fa-solid fa-user-gear" style="margin: 5px; margin-right: 13px; color: black"></i>Staffs</a>
                    </div>
                    <div class="fadeIn third" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=DoctorList"><i class="fa-solid fa-user-doctor fa-lg" style="margin: 5px; margin-right: 16px; ;color: black"></i>Doctors</a>
                    </div>
                </span>
                <li>
                    <a href="MainController?action=AppointmentList">
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
                        <div style="display:flex; justify-content: space-between; align-items: center">
                            <h1>Doctor's Shift</h1>
                            <h1>Doctor Name: ${requestScope.doctorName}</h1>
                        </div>
                        
                        <table class="weekly_timetable">
                            <tr>
                                <th class="th-1st">Slot/Day</th>
                                <th>Mon</th>
                                <th>Tue</th>
                                <th>Wed</th>
                                <th>Thu</th>
                                <th>Fri</th>
                                <th>Sat</th>
                            </tr>
                            <tr>
                                <c:set var="slot" value="1"></c:set>
                                <c:set var="doctorShiftHashMap" value="${requestScope.doctorShiftHashMap}"></c:set>

                                <c:forEach items="${requestScope.shiftList}" var="item" varStatus="status">
                                    <c:if test="${status.index % 6 == 0}">
                                    <tr>
                                        <td>Slot ${slot}</td>
                                        <c:set var="slot" value="${slot + 1}"></c:set>
                                    </c:if>
                                    
                                        <c:choose>
                                            <c:when test="${doctorShiftHashMap[item.shiftID] != null}">
                                                <td style="background: #2eb4aa; color:white; opacity: 0.99" class="tr-2nd">
                                                    <a href="UnchooseDoctorShiftServlet?doctorID=${requestScope.doctorID}&shiftID=${item.shiftID}">${item.shiftID}</a> 
                                                </td>
                                                
                                            </c:when>
                                            <c:otherwise>
                                                <td  class="tr-2nd">
                                                    <a  href="ChooseDoctorShiftServlet?doctorID=${requestScope.doctorID}&shiftID=${item.shiftID}">Choose</a>
                                                </td>
                                                
                                            </c:otherwise>
                                        </c:choose>

                                    
                                    <c:if test="${(status.index + 1) % 6 == 0 || status.last}">
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </section> 
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
