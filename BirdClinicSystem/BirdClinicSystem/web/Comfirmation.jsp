<%-- 
    Document   : Comfirmation
    Created on : Jun 7, 2023, 7:50:00 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap" rel="stylesheet">

        <link href="style/confirmation.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

        <div class="containerr">
            <ul class="progressbar">
                <li class="completed">Scheduling</li>
                <li class="completed">Finish details</li>
                <li class="actived">Confirmation</li>
            </ul>
        </div>
        <%
            String[] months = {"January", "February", "March", "April", "May",
                "June", "July", "August", "September", "October", "November", "December"};
            int currentMonth = Integer.parseInt(request.getParameter("month"));
            String[] slots = {"8:00 - 9:30", "9:45 - 11:15", "12:30 - 14:00", "14:15 - 15:45", "16:00 - 17:30", "17:45 - 19:15"};
            int currentSlot = Integer.parseInt(request.getParameter("slot"));
        %>

        <div class="confirm-section">
            <a href="GoToFinishdetailsServlet?slot=${requestScope.slot}&date=${requestScope.date}&month=${requestScope.month}&year=${requestScope.year}&services=${requestScope.services}"><h5><span><i class="fa fa-chevron-left" aria-hidden="true"></i></span> Back</h5></a>
            <h5 style="margin: 30px 0;">Review your information again and proceed to confirm. </h5>
            <form class="confirm-form" method="post" action="MainController?action=finishComfirmation">
                <h3  style="text-align: center; font-weight: bold; font-size: 35px; color: #0E9202; margin-bottom: 30px;">Confirmation</h3>
                <table class="confirmation-detail">
                    <h5 style="color: rgba(0, 0, 0, 0.5)">Customer ${requestScope.name}</h5>
                    <tr>
                        <td><h4>Date</h4></td>
                        <td><h4>: <%=months[currentMonth]%> ${requestScope.date}, ${requestScope.year}</h4></td>
                    </tr>
                    <tr>
                        <td><h4>Time</h4></td>
                        <td><h4>: <%=slots[currentSlot - 1]%></h4></td>
                    </tr>
                    <tr>
                        <td><h4>Services</h4></td>
                        <td><h4>: ${requestScope.services}</h4></td>
                    </tr>
                </table>
                <input type="hidden" name="slot" value="${requestScope.slot}">
                <input type="hidden" name="date" value="${requestScope.date}">
                <input type="hidden" name="month" value="${requestScope.month}">
                <input type="hidden" name="year" value="${requestScope.year}">
                <input type="hidden" name="services" value="${requestScope.services}">
                <input type="hidden" name="name" value="${requestScope.name}">
                <input type="hidden" name="birdName" value="${requestScope.birdName}">
                <input type="hidden" name="phone" value="${requestScope.phone}">
                <input type="hidden" name="email" value="${requestScope.email}">
                <input type="hidden" name="address" value="${requestScope.address}">
                <input type="hidden" name="note" value="${requestScope.note}"/>
                <div class="buttons">
                    <a href="ScheduleAppointment.jsp" class="btnCancel" style="background-color: #B70404;">Cancel</a>
                    <input type="submit" value="Confirm"/>
                </div>                    
            </form>
        </div>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "Confirmation.jsp");
            }
        </script>
    </body>
</html>
