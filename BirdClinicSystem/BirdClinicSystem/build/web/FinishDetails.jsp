<%-- 
    Document   : FinishDetails
    Created on : Jun 7, 2023, 7:19:58 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.BirdDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="style/finishDetails.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.customer == null}">
                <c:import url="header.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="headerUser.jsp"/>
            </c:otherwise>
        </c:choose>

        <%
            String[] months = {"January", "February", "March", "April", "May",
                "June", "July", "August", "September", "October", "November", "December"};
            int currentMonth = Integer.parseInt(request.getParameter("month"));
            String[] slots = {"8:00 - 9:30", "9:45 - 11:15", "12:30 - 14:00", "14:15 - 15:45", "16:00 - 17:30", "17:45 - 19:15"};
            int currentSlot = Integer.parseInt(request.getParameter("slot"));
        %>

        <div class="containerr">
            <ul class="progressbar">
                <li class="completed">Scheduling</li>
                <li class="actived">Finish details</li>
                <li>Confirmation</li>
            </ul>
        </div>

        <div class="detail-section">
            <a href="ScheduleAppointment.jsp"><h5><span><i class="fa fa-chevron-left" aria-hidden="true"></i></span> Back</h5></a>
            <div class="appointSummary">
                <h5>${requestScope.services}</h5>
                <p><%=slots[currentSlot - 1]%><br><%=months[currentMonth]%> ${requestScope.date}, ${requestScope.year}</p>
            </div>
            <h5 style="margin: 30px 0;">Please provide the required information to complete the appointment booking at our bird clinic.</h5>
            <form action="MainController?action=finishDetail" method="post" class="appointDetailForm">
                <div class="detail txtName">
                    <h6>Name<span style="color: red; font-size: 20px;">*</span><br></h6>
                    <input type="text" name="txtName" value="${sessionScope.customer.getFullname()}" required=""/>
                </div>
                <div class="detail txtBirdName">
                    <h6>Bird Name<span style="color: red; font-size: 20px;">*</span><br></h6>
                    <!--<input type="text" name="txtBirdName" required=""/>-->
                    <select name="txtBirdName" style="padding-top: 0; padding-bottom: 0;">
                        <c:forEach var="bird" items="${BirdDAO.getAllCustomerBirds(sessionScope.UserID)}">
                            <option value="${bird.getBird_name()}">${bird.getBird_name()}</option>
                        </c:forEach>    
                    </select>
                </div>
                <div class="detail txtPhone">
                    <h6>Phone<span style="color: red; font-size: 20px;">*</span><br></h6>
                    <input type="text" name="txtPhone" value="${sessionScope.customer.getPhone()}" required=""/>
                </div>
                <div class="detail txtEmail">
                    <h6>Email<span style="color: red; font-size: 20px;">*</span><br></h6>
                    <input type="text" name="txtEmail" value="${sessionScope.customer.getEmail()}" required=""/>
                </div>
                <div class="detail txtAddress">
                    <h6>Address<span style="color: red; font-size: 20px;">*</span><br></h6>
                    <input type="text" name="txtAddress" value="${sessionScope.customer.getAddress()}" required=""/>
                </div>
                <div class="detail txtDescription">
                    <h6>Description<br></h6>
                    <textarea name="txtDescription" rows="4" cols=""></textarea>
                </div>
                <input type="hidden" name="slot" value="${requestScope.slot}">
                <input type="hidden" name="date" value="${requestScope.date}">
                <input type="hidden" name="month" value="${requestScope.month}">
                <input type="hidden" name="year" value="${requestScope.year}">
                <input type="hidden" name="services" value="${requestScope.services}">
                <div class="nextBtn">
                    <input type="submit" value="Next" id="nextBtn" />
                </div>            
            </form>
        </div>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "FinishDetails.jsp");
            }
        </script>
    </body>
</html>
