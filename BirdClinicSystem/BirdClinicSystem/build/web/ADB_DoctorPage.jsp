<%-- 
    Document   : ADB_HomePage
    Created on : Jul 5, 2023, 2:37:46 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.DoctorDAO"%>
<%@page import="DTO.Doctor"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="DashBoardCSS/style.css" />
        <link rel="stylesheet" href="DashBoardCSS/Customers.css" />
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
        <%@include file="NotificationMess.jsp" %>
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
                    <div class="fadeIn first" style="padding: 10px;  ">                           
                        <a class="hover_div" href="MainController?action=CustomerList"><i class="fa-solid fa-user-pen " style="margin: 5px; margin-right: 13px; color: black"></i>Customers</a>
                    </div>
                    <div class="fadeIn second" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=StaffList"><i class="fa-solid fa-user-gear" style="margin: 5px; margin-right: 13px; color: black"></i>Staffs</a>
                    </div>
                    <div class="fadeIn third" style="padding: 10px;background: #95EBD1;">
                        <a class="hover_div_cus" href="MainController?action=DoctorList"><i class="fa-solid fa-user-doctor fa-lg" style="margin: 5px; margin-right: 16px; ;color: black"></i>Doctors</a>
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
                        <form action="MainController" method="POST">
                            <div class="row1">
                                <c:set var="totalDoc" value="0"></c:set>
                                <c:forEach var="list" items="${requestScope.doctorList}">
                                    <c:set var="totalDoc" value="${totalDoc + 1}" />
                                </c:forEach>
                                <div class="col-sm-2">
                                    <h4 style="margin:0px;">Doctors</h4>
                                    <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalDoc} Doctors</p>
                                </div>
                                <div class="col-sm-2" style="border-bottom: 1px solid">
                                    <input type="text" name="txtkeyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 10px; border: none; width: 80%">
                                    <button value="DoctorList" style="border:none; background-color: white;" name="action">
                                        <svg xmlns="http://www.w3.org/2000/svg"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                        </svg>
                                    </button>
                                </div>
                                <select name="txtsearchby" class="selecttextbox col-sm-2" style="width: 20%; margin-left: 25px">
                                    <option value="docid" ${requestScope.searchby == 'docid' ? 'selected' : ''}>ID</option>
                                    <option value="docmail" ${requestScope.searchby == 'docmail' ? 'selected' : ''}>Email</option>
                                    <option value="docname" ${requestScope.searchby == 'docname' ? 'selected' : ''}>Name</option>
                                    <option value="docphone" ${requestScope.searchby == 'docphone' ? 'selected' : ''}>Phone</option>
                                </select>

                                <div class="col-sm-1">
                                    <div class="form-check cen1">
                                        <input class="form-check-input" style="margin-top: 10px; color:green" type="checkbox" value="active" id="defaultCheck1" name="txtactive" ${requestScope.Active == 'active' ? 'checked' : ''}>
                                        <label class="form-check-label" for="defaultCheck1">
                                            Active
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" style="margin-top: 10px; color:red" type="checkbox" value="suspended" id="defaultCheck1" name="txtsuspended" ${requestScope.Suspended == 'suspended' ? 'checked' : ''}>
                                        <label class="form-check-label" for="defaultCheck1">
                                            Suspended
                                        </label>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <a class="button" style="padding: 20px 30px;" href="ADB_AddDoctor.jsp">Add New Doctors</a>
                                </div>
                            </div>
                        </form>

                        <table border="1" width="100%" >                                
                            <tbody>
                                <tr class="table-cus">
                                    <th>ID</th>
                                    <th>EMAIL</th>
                                    <th>FULL NAME</th>
                                    <th>GENDER</th>
                                    <th>ADDRESS</th>
                                    <th>PHONE</th>
                                    <th>STATUS</th>
                                    <th>SCHEDULE</th>
                                    <th>SALARY</th>
                                </tr>
                                <c:forEach var="doctor" items="${requestScope.doctorList}" varStatus="status">
                                    <tr>
                                        <td>${doctor.getDocID()}</td>
                                        <td>${doctor.getEmail()}</td>
                                        <td>${doctor.getFullname()}</td>
                                        <td>${doctor.getGender()}</td>
                                        <td>${doctor.getAddress()}</td>
                                        <td>${doctor.getPhone()}</td>
                                        <td style="text-align: center;">
                                            <c:url var="mylink" value="MainController">
                                                <c:param name="email" value="${doctor.getEmail()}"></c:param>
                                                <c:param name="status" value="${doctor.getStatus()}"></c:param>
                                                <c:param name="action" value="UpdateStatus"></c:param>
                                                <c:param name="source" value="doctorList"></c:param>
                                            </c:url>
                                            <c:if test="${doctor.getStatus() eq 0}">
                                                <a class="button" href="${mylink}">Active</a>
                                            </c:if>
                                            <c:if test="${doctor.getStatus() eq 1}">
                                                <a class="button-sus" href="${mylink}">Suspended</a>
                                            </c:if>
                                        </td>
                                        <td><a class="button" href="ViewDoctorShiftServlet?doctorID=${doctor.getDocID()}"><i class="fa-solid fa-clipboard-list fa-xl"></i></a></td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <input style="width: 50%" type="number" min="0" step="1" value="${DoctorDAO.getDoctorByDocID(doctor.getDocID()).getSalary()}" name="txtsalary">
                                                <input type="hidden" name="doctorID" value="${doctor.getDocID()}">
                                                <button class="button" style="padding: 10px 10px;" value="ChangeDoctorSalary" name="action">Submit</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>    
                    </div>
                </div>
            </div>
        </section> 
        <!--Confirm change ACTIVE or SUPENDED-->
        <div id="PopUpMess" class="modal-container ">
            <div class="form-popup-header" id="myForm">
                <div class="img-ab" >                                         
                    <div class="pic" >
                        <img src="img/pl 1.png" style="height: 75px;" alt=""/>               
                    </div>
                </div>
                <form action="MainController" class="form-container" method="POST">
                    <div style="margin: 25px; margin-top: 20px; font-size: 24px; font-weight: bold;">
                        Do You Want to Change?
                    </div>
                    <div style="display: flex; justify-content: center;">
                        <a href="MainController?action=Logout" class="button-con">Confirm</a>
                        <a href="#" class=" button-cancel" style="margin-left: 30px;">Cancel</a>
                    </div>

                </form> 

            </div>
        </div>
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
