<%-- 
    Document   : ADB_HomePage
    Created on : Jul 5, 2023, 2:37:46 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@page import="DAO.InvoiceDAO"%>
<%@page import="DAO.AppointmentDAO"%>
<%@page import="DAO.CustomersDAO"%>
<%@page import="DAO.ServiceDAO"%>
<%@page import="DAO.PrescriptionDAO"%>
<%@page import="DAO.MedicineDAO"%>
<%@page import="DTO.Invoice"%>
<%@page import="DTO.AppointmentsForm"%>
<%@page import="DTO.Customers"%>
<%@page import="DTO.Services"%>
<%@page import="DTO.PrescriptionDetail"%>
<%@page import="DTO.Medicine"%>

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
                        <a href="MainController?action=InvoiceList" class="active">
                            <i class="bx bx-grid-alt"></i>
                            <span class="links_name">Dashboard</span>
                        </a>
                    </li>
                    <span class="dropdown-btn">   
                        <i class="fa-regular fa-user" style=" min-width: 60px; margin-left: 6px;font-size: 18px;color: rgba(11, 183, 131, 1); "><span class="links_name" style="margin-left: 22px;font-weight: 400;white-space: nowrap; color: black">Users</span></i>
                    </span>
                    <span class="dropdown-container">
                        <div class="fadeIn first" style="padding: 10px;">                           
                            <a class="hover_div" href="MainController?action=CustomerList"><i class="fa-solid fa-user-pen " style="margin: 5px; margin-right: 15px; color: black"></i>Customers</a>
                        </div>
                        <div class="fadeIn second" style="padding: 10px;">
                            <a class="hover_div" href="MainController?action=StaffList"><i class="fa-solid fa-user-gear" style="margin: 5px; margin-right: 15px; color: black"></i>Staffs</a>
                        </div>
                        <div class="fadeIn third" style="padding: 10px;">
                            <a class="hover_div" href="MainController?action=DoctorList"><i class="fa-solid fa-user-doctor fa-lg" style="margin: 5px; margin-right: 18px; ;color: black"></i>Doctors</a>
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
                    <div class="overview-boxes">   
                        <div class="box" style="background: #69E3A9; color: white">
                            <c:set var="totalCus" value="0"></c:set>
                                <c:forEach var="list" items="${CustomersDAO.getAllCustomers()}">
                                    <c:set var="totalCus" value="${totalCus + 1}" />
                                </c:forEach>
                            <div class="logo-box"><i class="fa-solid fa-users fa-2xl" style="color: rgba(0, 172, 79, 1);"></i></div>
                            <div class="right-side">
                                <div class="box-topic">Total Customers</div>
                                <div class="number">${totalCus}</div>                         
                            </div>

                        </div>
                        <div class="box" style="background: #69C9FF;color: white">
                            <c:set var="totalAppointments" value="0"></c:set>
                                <c:forEach var="list" items="${AppointmentDAO.getAllAppointmentList()}">
                                    <c:set var="totalAppointments" value="${totalAppointments + 1}" />
                                </c:forEach>
                            <div class="logo-box"><i class="fa-solid fa-calendar fa-2xl" style="color: rgba(0, 172, 79, 1);"></i></div>
                            <div class="right-side" >
                                <div class="box-topic">Total Appointment</div>
                                <div class="number">${totalAppointments}</div>                              
                            </div>
                        </div>
                        <div class="box" style="background-color: rgba(27, 197, 189, 1);color: white">
                            <c:set var="totalInv" value="0"></c:set>
                            <c:set var="totalRevenue" value="0"></c:set>
                                <c:forEach var="invoice" items="${InvoiceDAO.getAllInvoice()}">
                                    <c:set var="totalInv" value="${totalInv + 1}" />
                                    <c:set var="totalRevenue" value="${totalRevenue + invoice.totalMoney}" />
                                </c:forEach>
                            <div class="logo-box"><i class="fa-solid fa-arrow-trend-up fa-2xl" style="color: rgba(0, 172, 79, 1);"></i></div>
                            <div class="right-side">
                                <div class="box-topic">Total Revenue</div>
                                <div class="number">$
                                <fmt:formatNumber pattern="#,##0.00">${totalRevenue}</fmt:formatNumber>
                            </div>
                            </div>

                        </div>
                    </div>
                    <div class="sales-boxes">
                        <div class="recent-sales box">
                            <form action="MainController" method="POST">
                            <div class="row1">
                                <c:set var="totalInv" value="0"></c:set>
                                <c:forEach var="list" items="${InvoiceDAO.getAllInvoice()}">
                                    <c:set var="totalInv" value="${totalInv + 1}" />
                                </c:forEach>
                                <div class="col-sm-2">
                                    <h4 style="margin:0px;">Invoice</h4>
                                    <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalInv} Invoices</p>
                                </div>
                                <div class="col-sm-2" style="border-bottom: 1px solid">
                                    <input type="text" name="txtkeyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 10px; border: none; width: 80%">
                                    <button value="InvoiceList" style="border:none; background-color: white;" name="action">
                                        <svg xmlns="http://www.w3.org/2000/svg"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                        </svg>
                                    </button>
                                </div>
                                <select name="txtsearchby" class="selecttextbox col-sm-2" style="width: 20%; margin-left: 25px">
                                    <option value="invoiceid" ${requestScope.searchby == 'appid' ? 'selected' : ''}>ID</option>
                                    <option value="cusname" ${requestScope.searchby == 'cusname' ? 'selected' : ''}>Customer Name</option>
                                    <option value="docname" ${requestScope.searchby == 'docname' ? 'selected' : ''}>Doctor Name</option>     
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
                            </div>
                            </form>
                                    
                            <table border="1" width="100%" >                                
                                <tbody>
                                    <tr class="table-cus">
                                        <th>INVOICE ID</th>
                                        <th>CUSTOMER NAME</th>
                                        <th>DATE & TIME</th>
                                        <th>SERVICES</th>
                                        <th>DOCTOR NAME</th>
                                        <th>PRESCRIPTION</th>
                                        <th>TOTAL</th>
                                        <th>DETAILS</th>
                                    </tr>
                                    <c:forEach var="invoice" items="${requestScope.invoice}" varStatus="status">
                                        <c:set var="details" value="${requestScope.invoiceHashMap[invoice.invoiceID]}"></c:set>
                                    <tr>
                                        <td>${invoice.invoiceID}</td>
                                        <td>${details.customerName}</td>
                                        <td style="width: 15%">
                                            <h5 style="margin:0px; font-size: 20px;color:rgba(62, 214, 168, 1);">${details.getDate()}</h5>
                                            <p style="margin:0px; font-size: 17px; color:rgba(201, 202, 202, 1);">${details.getStartTime().substring(0,5)}-${details.getEndTime().substring(0,5)}</p>
                                        </td>
                                        <td>${details.serviceName}</td>
                                        <td>${details.doctorName}</td>
                                        <td>${invoice.prescriptionID}</td>
                                        <td>$<fmt:formatNumber pattern="#,##0.00">${invoice.totalMoney}</fmt:formatNumber></td>
                                        <td style="text-align: center;"><a href="#disclaimer${status.index}" ><i class="fa-solid fa-bars fa-xl" style="color: #40d6a8;"></i></a></td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>                  
                        </div>
                    </div>
                </div>          
    </section> 
        <!--        -----------------------------------Invoice----------------------------------->
        <c:forEach var="invoice" items="${requestScope.invoice}" varStatus="status">
        <c:set var="details" value="${requestScope.invoiceHashMap[invoice.invoiceID]}"></c:set>
        <div id="disclaimer${status.index}" class="modal-container ">
            <div class="form-in" id="myForm" style="width: 65%; max-width: 1000px">
                <form action="MainController" class="form-container" method="POST" style="width: 100%">
                    <div class="flex-header" style="display: flex; justify-content: flex-end">                  
                        <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                            </svg></a>
                    </div>
                    <div class="row1" style="margin: 5px">
                        <div class="pic col-md-6" >
                            <img src="img/pl 1.png" style="height: 100px; margin-right: 10px;" alt=""/>
                            <div class="text-logo">
                                <h3>Bird Clinic</h3>
                                <p>0123456789</p>
                                <p>wearebirdclinic@gmail.com </p>
                            </div>
                        </div> 
                        <div class="col-md-6">
                            <h1>Invoice Form</h1>
                        </div>
                    </div>
                    <div class="row1" style="display: flex; justify-content: space-between; margin: 5px">
                        <div class="text-logo">
                            <p>Invoice to</p>
                            <h3>${details.customerName}</h3>
                            
                        </div> 
                        <div class="text-logo pic">
                            <div class="text-logo">
                                <h3>Invoice </h3>
                                <h3>Date</h3>
                                <h3>Slot time</h3>
                            </div> 
                            <div class="text-logo">
                                <p>${invoice.invoiceID}</p>
                                <p>${details.getDate()}</p>
                                <p>${details.getStartTime().substring(0,5)}-${details.getEndTime().substring(0,5)}</p>
                            </div> 
                        </div>    
                    </div>
                    <c:set var="serviceSubtotal" value="0"></c:set>
                    <c:set var="medicineSubtotal" value="0"></c:set>
                    <div class="row-hai">
                        <h3 class="col-md-6">SERVICE</h3>
                        <h3 class="col-md-6">PRICE</h3>
                    </div>
                    <c:forEach var="service" items="${ServiceDAO.getServiceListByInvoiceID(invoice.invoiceID)}" >
                    <div class="blend">
                        <p class="col-md-6">${service.getServName()}</p>
                        <fmt:formatNumber var="serviceCost" type="number" value="${service.price}" pattern="#,##0.00"></fmt:formatNumber>
                        <p class="col-md-6">$${serviceCost}</p>
                    </div>
                    <c:set var="serviceSubtotal" value="${serviceSubtotal + serviceCost}"></c:set>
                    </c:forEach>
                    <br>
                    <div class="row-ba">
                        <h3>Item Description</h3>
                        <h3>Quantity</h3>
                        <h3>Unit Price</h3>
                        <h3>Total</h3>
                    </div>
                    <c:set var="MedicineTotal" value="0"></c:set>
                    <c:set var="ServiceTotal" value="${serviceSubtotal}"/>
                    <c:forEach var="pres" items="${PrescriptionDAO.getPrescriptionList(invoice.prescriptionID)}">
                        <c:set var="medicine" value="${MedicineDAO.getMedicineByID(pres.medID)}"></c:set>
                    <div class="blend-2">
                        <h3>${medicine.medName}</h3>
                        <p>${pres.quantity}</p>
                        <p>$${medicine.medPrice}</p>
                        <fmt:formatNumber var="medicineCost" type="number" value="${pres.quantity * medicine.medPrice}" pattern="#,##0.00"></fmt:formatNumber>
                        <p>$${medicineCost}</p>
                    </div>
                    <c:set var="medicineSubtotal" value="${medicineSubtotal + medicineCost}"></c:set>
                    </c:forEach>
                    <br>
                    <div class="row1" style="display: flex; justify-content: center; gap: 300px; margin: 5px">
                        <fmt:formatNumber var="MedicineTotal" type="number" value="${medicineSubtotal}" pattern="#,##0.00"></fmt:formatNumber>
                        <fmt:formatNumber var="ServiceTotal" type="number" value="${serviceSubtotal}" pattern="#,##0.00"></fmt:formatNumber>
                        <fmt:formatNumber var="SubTotal" type="number" value="${serviceSubtotal + medicineSubtotal}" pattern="#,##0.00"></fmt:formatNumber>
                        <fmt:formatNumber var="Tax" type="number" value="${SubTotal * 10/100}" pattern="#,##0.00"></fmt:formatNumber>
                        <fmt:formatNumber var="Total" type="number" value="${Tax + SubTotal}" pattern="#,##0.00"></fmt:formatNumber>
                        <div class="text-logo">
                            <h3>Bills</h3>
                            <h3>Services: $${serviceSubtotal}</h3>
                            <h3>Medicines: $${MedicineTotal} </h3>
                        </div>              
                        <div class="text-logo pic" style="gap: 50px">                           
                            <div class="text-logo">
                                <p>Subtotal</p>
                                <p>Tax(10%)</p>
                                <h3>Total </h3>
                            </div> 
                            <div class="text-logo">
                                <p>$${SubTotal}</p>
                                <p>$${Tax}</p>
                                <p>$${Total}</p>
                            </div> 
                        </div>    
                    </div>
                </form>
            </div>  
        </div>
        </c:forEach>
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
    <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "MainController?action=InvoiceList");
            }
        </script>
</body>
</html>
