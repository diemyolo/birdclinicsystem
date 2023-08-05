<%@page import="DTO.Users"%>
<%@page import="DTO.Appointments"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="DAO.UserDAO"%>
<%@page import="DAO.CustomersDAO"%>
<%@page import="DAO.AppointmentDAO"%>
<%@page import="DAO.MedRecordDAO"%>
<%@page import="DAO.BirdDAO"%>
<%@page import="DAO.DoctorDAO"%>
<%@page import="DAO.SlotDAO"%>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <!--<link href="css/StaffAppointmentList.css" rel="stylesheet">-->
        <link rel="stylesheet" href="style/dr_weekly_schedule.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" >
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.doctor == null}">
                <c:set var="warning" value="You need to log in as Doctor to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="DoctorHeader.jsp?appointment=aa"/>
            </c:otherwise>
        </c:choose>

        <c:set var="updateStatus" value="${AppointmentDAO.updateAppStatus()}"/>

        <div class="container-form" style="position: relative; top: 0px;">
            <div class="switch_view_btn">
                <a href="Doctor_AppointmentList.jsp">List</a>
                <a class="active_switch_btn" >Timetable</a>
            </div>
            <div class="form-white">
                <div class="row1">
                    <div class="titleApp col-sm-2">
                        <h3 style="margin:0px;">Appointments</h3>
                    </div>                    
                    <div class="filterApp col-sm-2"></div>
                    <div class="col-sm-7"></div>
                </div>
                <!--show doc schedule list-->
                <%
                    Users doctor = (Users) session.getAttribute("doctor");
                    String doctorid = DoctorDAO.getDoctorWithUserID(doctor.getUserID()).getDocID();

                    String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

                    ArrayList<LocalDate> dates = new ArrayList<>();
                    DateTimeFormatter dayformat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    Calendar calendar = Calendar.getInstance();
                    int weekYear = calendar.get(Calendar.YEAR);
                    int noOfWeek = calendar.get(Calendar.WEEK_OF_YEAR);

                    LocalDate startday = LocalDate.parse(String.format("%04d-W%02d-1", weekYear, noOfWeek), DateTimeFormatter.ISO_WEEK_DATE);
                    if (LocalDate.now().equals(startday.minusDays(1))) {
                        noOfWeek -= 1;
                        startday = startday.minusDays(7);
                    }
                    if (request.getAttribute("startday") != null) {
                        startday = (LocalDate) request.getAttribute("startday");
                    }
                    if (request.getAttribute("noOfWeek") != null) {
                        noOfWeek = (Integer) request.getAttribute("noOfWeek");
                    }
                    if (request.getAttribute("weekYear") != null) {
                        weekYear = (Integer) request.getAttribute("weekYear");
                    }

                    String pattern = "yyyy-MM-dd";
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
                    ArrayList<Appointments> appointlist = AppointmentDAO.getDoctorAppointmentList(doctorid, startday.format(formatter), startday.plusDays(6).format(formatter));
                    pageContext.setAttribute("StartDay", startday.format(formatter));
                    pageContext.setAttribute("EndDay", startday.plusDays(6).format(formatter));
                    LocalDate monday = null;
                    LocalDate sunday = null;
                %>
                <form action="SwitchDoctorScheduleServlet" method="post" style="margin-top: 30px;">
                    <div class="select-container mt-2" data-bs-theme="dark" style="width: 400px;">
                        <div style="display: flex; margin-bottom: 10px; gap: 10px">
                            <h5>Current Year: </h5>
                            <select class="select-box" name="weekYear" onchange="this.form.submit()">
                                <%
                                    for (int i = -2; i <= 2; i++) {
                                        if (calendar.get(Calendar.YEAR) + i == weekYear) {%>
                                <option style="background: #5cb85c; color: #fff;" selected="" value="<%= calendar.get(Calendar.YEAR) + i%>"><%= calendar.get(Calendar.YEAR) + i%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= calendar.get(Calendar.YEAR) + i%>"><%= calendar.get(Calendar.YEAR) + i%></option>
                                <% }
                                    }
                                %>
                            </select>
                        </div>

                        <div style="display: flex; margin-bottom: 10px; gap: 10px;">
                            <h5>Current week: </h5>
                            <select class="select-box" name="noOfWeek" onchange="this.form.submit()">
                                <%
                                    for (int i = 1; i <= 52; i++) {
                                        monday = LocalDate.parse(String.format("%04d-W%02d-1", weekYear, i), DateTimeFormatter.ISO_WEEK_DATE);
                                        sunday = monday.plusDays(6);
                                        if (i == noOfWeek) {
                                %>

                                <option style="background: #5cb85c; color: #fff;" selected="" value="<%= i%>">
                                    <%= dayformat.format(monday)%> - <%= dayformat.format(sunday)%>
                                </option>
                                <%
                                } else {
                                %>
                                <option value="<%= i%>">
                                    <%= dayformat.format(monday)%> - <%= dayformat.format(sunday)%>
                                </option>
                                <% }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                </form>
                <div style="margin-top: 20px; text-align: center; margin-bottom: -30px; font-weight: bold; font-size: 150%; letter-spacing: 1px;">Week starts at Monday, <%= dayformat.format(startday)%></div>
                <div style="display: flex; justify-content: space-between; width: 50%; margin: 0 auto; font-weight: bold; font-size: 120%;">
                    <% if (noOfWeek > 1) {
                    %>
                    <a href="MainController?action=SwitchDoctorSchedule&weekYear=<%= weekYear%>&noOfWeek=<%= noOfWeek - 1%>"><i class="fa-solid fa-chevron-left fa-lg" style="color: #000000;"></i></a>
                        <% }
                            if (noOfWeek < 52) {
                        %>
                    <a href="MainController?action=SwitchDoctorSchedule&weekYear=<%= weekYear%>&noOfWeek=<%= noOfWeek + 1%>"><i class="fa-solid fa-chevron-right fa-lg" style="color: #000000;"></i></a>
                        <% } %>
                </div>
                <table class="weekly_timetable">
                    <tr>
                        <th style="font-size: 20px; color: rgba(62, 214, 168, 1); font-weight: bold;">Slot\Day of week</th>
                            <% for (int i = 0; i < 7; i++) {%>   
                        <th style="background-color: rgba(62, 214, 168, 0.8);">
                            <h5 style="margin: 0px 10px; font-size: 20px; color: white; font-weight: bold;"><%= weekDays[i]%></h5>
                            <p style="margin: 0px; font-size: 17px; color: white;"><%= startday.plusDays(i).getDayOfMonth() + "/" + startday.plusDays(i).getMonthValue()%></p>
                        </th>
                        <% dates.add(startday.plusDays(i));
                            } %>
                    </tr>

                    <%  int slotnumber = 1;
                        int statusIndex = 1;
                    %>

                    <c:forEach var="slot" items="${SlotDAO.getAllSlot()}">
                        <tr>
                            <th>
                                <h5 style="margin: 0px; font-size: 20px; color: rgba(62, 214, 168, 1)">Slot ${slot.getSlotID()}</h5>
                                <p style="margin: 0px; font-size: 17px; color: rgba(201, 202, 202, 1)">${slot.getStartTime().substring(0,5)}-${slot.getEndTime().substring(0,5)}</p>
                            </th>
                            <%
                                for (int i = 0; i < 7; i++) {
                            %>
                            <td>
                                <%
                                    for (Appointments app : appointlist) {
                                        if (app.getAppointDate().equals(dates.get(i).format(formatter)) && app.getSlotID() == slotnumber) {%>
                                <a href="#disclaimer<%= statusIndex%>" class="appointment_index_anchor">
                                    <div class="appointment_index">
                                        <div style="background-color: rgba(0, 0, 0, 0.15); border-radius: 6px 6px 0 0;">
                                            <h6><%=app.getAppID()%></h6>
                                            <div class="horizontal_divider"></div>
                                        </div>                                                         
                                        <h6 style="font-size: 85%; padding: .2rem 0;"><%=AppointmentDAO.getAppointmentByIDWithServices(app.getAppID()).getServices()%></h6>
                                        <% if (app.getStatus() == 1) {%>
                                        <i class="fa-solid fa-circle fa-beat-fade" style="color: #ffa800; position: absolute; top: .3rem; right: .3rem;"></i>
                                        <% } else { %>
                                        <i class="fa-solid fa-circle-check" style="color: #0e9202; position: absolute; top: .3rem; right: .3rem;"></i>
                                        <% } %>
                                    </div>
                                </a>
                                <%
                                            statusIndex++;
                                        }
                                    }
                                %>
                            </td>
                            <%
                                }
                            %>
                        </tr>
                        <% slotnumber = slotnumber + 1;%>
                    </c:forEach>
                </table>
            </div>
        </div>
        <!------------------------ POPUP -------------------------->
        <c:set var="userID" value='${sessionScope.DocID}'/>
        <c:set var="docID" value='${DoctorDAO.getDoctorWithUserID(userID).getDocID()}'/>
        <c:set var="StartDay" value="${StartDay}" />
        <c:set var="EndDay" value="${EndDay}" />
        <c:set var="index" value="1" />
        <c:forEach var="app" items="${AppointmentDAO.getDoctorAppointmentList(docID, StartDay, EndDay)}">
            <div id="disclaimer${index}" class="modal-container ">
                <div class="form-popup " id="myForm" style="width: 65%; max-width: none">
                    <form action="MainController" class="form-container" method="POST" style="width: 100%">
                        <div class="flex-header" style="display: flex; justify-content: flex-end">                  
                            <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                </svg></a>
                        </div>
                        <div class="flex-header">
                            <div class="header-text">
                                <h1>Order Date</h1>
                                <p>Tuesday, 18/07/2023</p>
                            </div>
                            <div class="pic" >
                                <img src="img/pl 1.png" style="height: 75px;margin-right: 10px;" alt=""/>
                                <h1 style="color: black">Bird Clinic</h1>
                            </div>
                        </div>
                        <h1 style="margin: 30px auto;">Appointment Form</h1>                  
                        <div class="table-row">
                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Customer’s Name:</div>
                                    <input style="width: 141%;" class="textbox1" type="text" value="" placeholder="${MedRecordDAO.getCustomerByID(app.getCusID()).getFullname()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Bird’s Name:</div>
                                    <input style="width: 150%;" type="text" value=""  placeholder="${BirdDAO.getBirdInfo(app.getBirdID()).getBird_name()}" class="textbox1" readonly>
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Mobile number:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${MedRecordDAO.getCustomerByID(app.getCusID()).getPhone()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Address:</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${CustomersDAO.getUserByCusID(app.getCusID()).getAddress()}" class="textbox1" readonly>
                            </div>
                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Doctor In Charge:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${UserDAO.getUsersbyUserID(userID).getFullname()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1" style="background-color: white">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Scheduled date:</div>
                                    <input style="width: 141%;" class="textbox1" type="text" value=""  placeholder="${app.getAppointDate()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Slot Time:</div>
                                    <input style="width: 150%;" type="text" value=""  placeholder="${SlotDAO.getSlotBySlotID(app.getSlotID()).getStartTime().substring(0,5)}-${SlotDAO.getSlotBySlotID(app.getSlotID()).getEndTime().substring(0,5)}" class="textbox1"  readonly>
                                </div>                           
                            </div>
                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Service(s):</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${AppointmentDAO.getAppointmentByIDWithServices(app.getAppID()).getServices()}" class="textbox1" readonly>
                            </div>
                            <c:choose>
                                <c:when test="${AppointmentDAO.getAppoinmentNote(app.getAppID()) != null}">
                                    <div class="row1">
                                        <div style="width: 20%; padding: 5px; margin-left: 5px;">Customer note:</div>
                                        <input style="width: 79%;" type="text" value="" placeholder="${AppointmentDAO.getAppoinmentNote(app.getAppID())}" class="textbox1" readonly>
                                    </div>
                                </c:when>
                            </c:choose>
                        </div>
                    </form> 
                </div>
            </div>
            <c:set var="index" value="${index + 1}" />
        </c:forEach>
        <!--                /*--------------------------------------------------------------*/-->
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "Doctor_AppointmentSchedule.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</html>
