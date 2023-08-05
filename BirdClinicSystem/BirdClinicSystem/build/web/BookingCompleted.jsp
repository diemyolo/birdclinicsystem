<%-- 
    Document   : BookingCompleted
    Created on : Jun 8, 2023, 4:57:04 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>      
        <link href="style/bookingCompleted.css" rel="stylesheet"/>
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
        <div class="containerr">
            <ul class="progressbar">
                <li class="completed">Scheduling</li>
                <li class="completed">Finish details</li>
                <li class="completed">Confirmation</li>
            </ul>
        </div>
        <%
            String[] slots = {"8:00 - 9:30", "9:45 - 11:15", "12:30 - 14:00", "14:15 - 15:45", "16:00 - 17:30", "17:45 - 19:15"};
            int currentSlot = Integer.parseInt((String)request.getParameter("slot"));
        %>

        <div class="success-section">
            <h2 style="font-weight: bold; font-family: 'Poppins', sans-serif; text-align: center; font-size: 50px; color: #0e9202">Thank You!<i class="fa-regular fa-calendar-check fa-bounce" style="color: #0e9202; margin-left: 20px;"></i></h2>
            <h4 style="margin-top: 30px; text-align: center;">You have successfully booked an appointment at our bird clinic!<br> We are excited to provide you and your feathered companion with excellent care!</h4>
            <div class="redirect_AppointList">
                <h5><a href="MainController?action=CustomerAppointmentList" >Go to Appointment list <span><i class="fa-solid fa-arrow-right"></i></span></a></h5>
            </div>
            <div class="appointment-booked">
                <table class="appoointment-summary-table">
                    <tr>
                        <th>Customer</th>
                        <th>Bird</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Services</th>
                        <th>Doctor</th>
                        <th>Status</th>
                    </tr>
                    <tr>
                        <td>${requestScope.name}</td>
                        <td>${requestScope.birdName}</td>
                        <td>${requestScope.date}/${requestScope.month+1}/${requestScope.year}</td>
                        <td><%=slots[currentSlot - 1]%></td>
                        <td>${requestScope.services}</td>
                        <td>${requestScope.doctor}</td>
                        <td>Pending</td>
                    </tr>
                </table>
                <div class="buttons">
                    <a href="#cancelAppConfirm" class="btnCancel" style="background-color: #B70404;">Cancel</a>
                    <a href="#rescheduleApp">Reschedule</a>
                </div>
            </div>
        </div>

        <div id="cancelAppConfirm" class="confirmPopup">
            <form action="MainController" class="confirm_form" method="POST">
                <h1>
                    Confirm cancellation..
                </h1>
                <input type="hidden" name="slot" value="${requestScope.slot}">
                <input type="hidden" name="date" value="${requestScope.date}">
                <input type="hidden" name="month" value="${requestScope.month}">
                <input type="hidden" name="year" value="${requestScope.year}">
                <div class="buttons">
                    <button type="submit" name="action" value="cancelApp">Yes, cancel appointment</button>
                    <a href="#" class="btnCancel" style="background-color: #B70404;">No, stop canceling</a>                    
                </div>
            </form> 
        </div>

        <div id="rescheduleApp">
            <%  LocalDate currentDate = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String formattedDate = currentDate.format(formatter);%>
            <form action="MainController" class="reschedule_form" method="post">
                <h1>Rescheduling</h1>
                <h6 style="margin-top: 20px;">Rescheduling from <span>${requestScope.date}/${requestScope.month+1}/${requestScope.year}</span> at <span><%=slots[currentSlot - 1]%></span> to: </h6>
                <input type="hidden" name="slot" value="${requestScope.slot}">
                <input type="hidden" name="date" value="${requestScope.date}">
                <input type="hidden" name="month" value="${requestScope.month}">
                <input type="hidden" name="year" value="${requestScope.year}">
                <input type="hidden" name="name" value="${requestScope.name}">
                <input type="hidden" name="birdName" value="${requestScope.birdName}">
                <input type="hidden" name="services" value="${requestScope.services}">
                <input type="hidden" name="doctor" value="${requestScope.doctor}">

                <div class="reschedule_wrapper">
                    <input type="date" min="<%=formattedDate%>" name="resDate" onchange="functionOnChange(event)"/>
                    <div id="reschedule_slots"></div>
                </div>

                <div class="buttons">
                    <button type="submit" name="action" value="rescheduleApp">Reschedule</button>
                    <a href="#" class="btnCancel" style="background-color: #B70404;">Cancel</a>                    
                </div>
            </form>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script>
                        if (window.history.replaceState) {
                            window.history.replaceState(null, null, "booking-completed");
                        }
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
</html>
