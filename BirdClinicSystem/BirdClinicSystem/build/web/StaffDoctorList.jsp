<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/StaffAppointmentList.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            .appoint-header{
                display: flex;
                justify-content: flex-end;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <%
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            Date firstDateOfWeek = calendar.getTime();

            calendar.add(Calendar.DATE, 6);
            Date lastDateOfWeek = calendar.getTime();
        %>

        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.staff == null}">
                <c:set var="warning" value="You need to log in as Staff to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="StaffHeader.jsp?doctors=a"/>
            </c:otherwise>
        </c:choose>

        <div class="container-form">
            <div class="form-white">
                <c:set var="totalDoctorList" value="0"></c:set>
                <c:forEach var="doctor" items="${requestScope.doctorList}">
                    <c:set var="totalDoctorList" value="${totalDoctorList + 1}" />
                </c:forEach>
                <form action="MainController" class="row1" method="post">
                    <div class="col-sm-2">
                        <h4 style="margin:0px; text-align: center">Doctors List</h4>
                        <p style="margin:0px; color:rgba(201, 202, 202, 1); text-align: center">Show ${totalDoctorList} appointments</p>
                    </div>

                    <div class=" col-sm-3 search">
                        <input type="text" name="keyword" placeholder="Search" class="border-revmove" style="outline: none; font-size: 25px;" value="${requestScope.keyword}">

                        <button type="submit" value="Search Doctor" name="action" >
                            <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                            </svg>
                        </button>
                    </div>
                    <div class="col-sm-2">
                        <select name="chooseBy" class="selecttextbox">
                            <c:choose>
                                <c:when test="${requestScope.chooseBy == 'id'}">
                                    <option value="id" selected>ID</option>
                                    <option value="name">Name</option>
                                </c:when>
                                <c:when test="${requestScope.chooseBy == 'name'}">
                                    <option value="id">ID</option>
                                    <option value="name" selected>Name</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="id">ID</option>
                                    <option value="name">Name</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>

                    <div class="col-sm-1">
                        <div class="form-check cen1">
                            <input class="form-check-input" style="margin-top: 10px;" type="radio" value="0" id="defaultCheck1" name="status" <c:if test="${status == 0}">checked</c:if>>
                                <label style="color:rgba(27, 197, 189, 1)" class="form-check-label" for="defaultCheck1">Free</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" style="margin-top: 10px;"  type="radio" value="1" id="defaultCheck1" name="status" <c:if test="${status == 1}">checked</c:if>>
                                <label style="color:red" class="form-check-label" for="defaultCheck1">Busy</label>
                            </div>

                        </div>

                        <div class="col-sm-3 appoint-header">
                            <div class="box-shade">
                                <p style="margin: 0px;margin-bottom: -8px; padding: 0px; font-size: 15px;">Start with</p>
                                <input type="Date" class="Date-box" name="startDate" value="<c:if test="${empty requestScope.startDate}"><fmt:formatDate value="<%=firstDateOfWeek%>" pattern="yyyy-MM-dd" /></c:if><c:if test="${not empty requestScope.startDate}"><c:out value="${requestScope.startDate}" /></c:if>"> 
                            </div>                      
                            <div class="box-shade">
                                <p style="margin: 0px; margin-bottom: -8px; padding: 0px; font-size: 15px;">End with</p>
                                    <input type="Date" class="Date-box" name="endDate" value="<c:if test="${empty requestScope.endDate}"><fmt:formatDate value="<%=lastDateOfWeek%>" pattern="yyyy-MM-dd" /></c:if><c:if test="${not empty requestScope.endDate}"><c:out value="${requestScope.endDate}" /></c:if>">
                            </div> 
                        </div>

                    </form>

                    <div style=" margin-top:50px">
                        <table class="tablecc">                                                               
                            <tr class="table-tr1" >
                                <td>DOCTOR ID</td>
                                <td>DOCTOR NAME</td>
                                <td>GENDER</td>
                                <td>OPERATION TIME</td>
                                <td>STATUS</td>
                                <td></td>
                            </tr>
                        <c:forEach var="doctor" items="${requestScope.doctorList}">
                            <c:if test="${requestScope.status == requestScope.doctorStatusHashMap[doctor.docID] || requestScope.status==null}">
                                <tr class="table-tr">
                                    <td>${doctor.docID}</td>
                                    <td>${doctor.fullname}</td>
                                    <td>
                                        ${doctor.gender}
                                    </td>
                                    <td>
                                        <div style="margin:0px; font-size: 20px;color:rgba(62, 214, 168, 1)">
                                            <c:forEach var="appointmentDate" items="${requestScope.appointmentDateHashMap[doctor.docID]}">
                                                <h5 style="margin:0px; font-size: 20px;color:rgba(214, 89, 62, 1)">${appointmentDate}</h5>         
                                                <c:forEach var="slot" items="${requestScope.slotHashMap[appointmentDate]}">
                                                    <fmt:parseDate value="${slot.startTime}" pattern="HH:mm:ss.SSSSSSS" var="start" />
                                                    <fmt:parseDate value="${slot.endTime}" pattern="HH:mm:ss.SSSSSSS" var="end" />
                                                    <fmt:formatDate value="${start}" pattern="HH:mm" var="start" />
                                                    <fmt:formatDate value="${end}" pattern="HH:mm" var="end" />
                                                    <p style="margin:0px; font-size: 17px; color:rgba(201, 202, 202, 1);">
                                                        ${start} - ${end}
                                                    </p>
                                                </c:forEach>
                                            </c:forEach>
                                        </div>

                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${requestScope.doctorStatusHashMap[doctor.docID] == 0}">
                                                <div class="completed">Free</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="completed" style="background-color:rgba(255, 226, 229, 1); color:rgba(246, 78, 96, 1);">Busy</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>                       
                                    <td><i class="fa-solid fa-user" style="color: #40d6a8;"></i></td> 
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
        <!--             -----------POPUP-NO INVOICE----------   -->
        <div id="disclaimer" class="modal-container ">
            <div class="form-popup " id="myForm">

                <form action="MainController" class="form-container" method="POST">
                    <div class="flex-header" style="display: flex; justify-content: flex-end">                  
                        <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                            </svg></a>
                    </div>
                    <div class="flex-header">
                        <div class="header-text">
                            <h1>Order Date</h1>
                            <p>monday, may 29th, 2023</p>
                        </div>
                        <div class="pic" >
                            <img src="img/pl 1.png" style="height: 75px;margin-right: 10px;" alt=""/>
                            <h1 style="color: black">Bird Clinic</h1>
                        </div>
                    </div>
                    <h1 style="margin: 30px auto;">Appointment Form</h1>
                    <table class="form-table">
                        <tr>
                            <td class="left-name">Customer’s Name</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1 hai-class" ></td>
                            <td class="right-name">Bird’s Name</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1" ></td>
                        </tr>
                        <tr>
                            <td class="left-name">Mobile number</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1 hai-class" ></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="left-name">Address</td>
                            <td colspan="3"><input type="text" value="" name="txtFullName" class="textbox1" ></td>

                        </tr>
                        <tr>
                            <td class="left-name">Doctor in charge</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1 hai-class" ></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="left-name">Scheduled date</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1 hai-class" ></td>
                            <td class="right-name">Slot time</td>
                            <td><input type="text" value="" name="txtFullName" class="textbox1" ></td>
                        </tr>
                        <tr>
                            <td class="left-name">Service(s)</td>
                            <td colspan="3"><input type="text" value="" name="txtFullName" class="textbox1" ></td>

                        </tr>
                        <tr>
                            <td class="left-name">Customer’s note</td>
                            <td colspan="3"><input type="text" value="" name="txtFullName" class="textbox1" ></td>                       
                        </tr>
                        <tr>                            
                            <td colspan="4"><input type="button" style="margin-top: 30px; padding: 12px 40px; background-color: green;color: white" value="Submit" ></td>                            
                        </tr>

                    </table>
            </div>
        </form> 
    </div>


    <!--                /*--------------------------------------------------------------*/-->
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, "MainController?action=Search Doctor");
        }
    </script>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
