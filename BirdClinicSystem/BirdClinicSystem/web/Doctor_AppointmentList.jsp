<%@page import="DAO.UserDAO"%>
<%@page import="DAO.CustomersDAO"%>
<%@page import="DAO.AppointmentDAO"%>
<%@page import="DAO.MedRecordDAO"%>
<%@page import="DAO.BirdDAO"%>
<%@page import="DAO.DoctorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/StaffAppointmentList.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" >

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
                <a class="active_switch_btn">List</a>
                <a href="Doctor_AppointmentSchedule.jsp">Timetable</a>
            </div>
            <c:set var="userID" value='${sessionScope.DocID}'/>
            <c:set var="docID" value='${DoctorDAO.getDoctorWithUserID(userID).getDocID()}'/>
            <c:set var="totalAppointments" value="0"></c:set>
            <c:forEach var="list" items="${requestScope.filteredList == null ? AppointmentDAO.getDoctorAppointmentList(docID, keyword) : requestScope.filteredList}">
                <c:set var="totalAppointments" value="${totalAppointments + 1}" />
            </c:forEach>
            <div class="form-white">
                <div class="row1">
                    <div class="titleApp col-sm-2">
                        <h3 style="margin:0px;">Appointments</h3>
                        <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalAppointments} appointments</p>
                    </div>

                    <form action="Doctor_AppointmentList.jsp" method="get" class="searchApp" style="display: flex; border-bottom: 2px solid">
                        <input type="text" name="keyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 25px;width: 300px; padding: 10px;background-color: initial; border: none">
                        <button type="submit">
                            <i class="fa-solid fa-magnifying-glass" style="color: #000000;font-size: 200%;"></i>
                        </button>
                    </form>
                    <div class="col-sm-4">
                    </div>
                    <div class="filterApp col-sm-2">
                        <div>
                            <form method="get" action="MainController">
                                <label style="color: rgba(27, 197, 189, 1); font-weight: bold;">
                                    <input type="radio" name="status" value="0">
                                    Completed
                                </label>
                                <label style="margin-left: 0.5rem; color: rgba(255, 168, 0, 1); font-weight: bold;">
                                    <input type="radio" name="status" value="1">
                                    Pending
                                </label>
                                <label style="margin-left: 0.5rem; font-weight: bold;">
                                    <input type="radio" name="status" value="" checked>
                                    All
                                </label>
                        </div>

                        <div class="btn-gg">
                            <input type="hidden" name="docID" value="${DoctorDAO.getDoctorWithUserID(sessionScope.DocID).getDocID()}"/>
                            <button type="submit" class="filterBtn" value="filterApp" name="action">
                                Filter
                            </button>
                        </div>

                        </form>
                    </div>
                    <div class="col-sm-7"></div>
                </div>

                <c:set var="slots" value="${['', '8:00 - 9:30', '9:45 - 11:15', '12:30 - 14:00', '14:15 - 15:45', '16:00 - 17:30', '17:45 - 19:15']}" />
                <c:choose>
                    <c:when test="${empty param.keyword}">
                        <c:set var="keyword" value=""/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="keyword" value="${param.keyword}"/>
                    </c:otherwise>
                </c:choose>
                <!--show doc appoint list-->
                <div style=" margin-top:50px">
                    <table class="tablecc">                                                               
                        <tr class="table-tr1" >
                            <td>APPOINTMENT ID</td>
                            <td>CUSTOMER NAME</td>
                            <td>DATE & TIME</td>
                            <td>BIRD NAME</td>
                            <td>SERVICES</td>                           
                            <td>STATUS</td>
                            <td></td>
                        </tr>
                        <c:set var="userID" value='${sessionScope.DocID}'/>
                        <c:set var="docID" value='${DoctorDAO.getDoctorWithUserID(userID).getDocID()}'/>
                        <c:forEach var="app" items="${requestScope.filteredList==null ? AppointmentDAO.getDoctorAppointmentList(docID, keyword) : requestScope.filteredList}" varStatus="status"> 
                            <tr class="table-tr">
                                <td>${app.getAppID()}</td>
                                <td>${MedRecordDAO.getCustomerByID(app.getCusID()).getFullname()}</td>
                                <td>
                                    <h5 style="margin:0px; font-size: 20px;color:rgba(62, 214, 168, 1)">${app.getAppointDate()}</h5>
                                    <p style="margin:0px; font-size: 17px; color:rgba(201, 202, 202, 1);">${slots[app.getSlotID()]}</p>
                                </td>
                                <td>${BirdDAO.getBirdInfo(app.getBirdID()).getBird_name()}</td>
                                <td>
                                    <div>${AppointmentDAO.getAppointmentByIDWithServices(app.getAppID()).getServices()}</div>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${app.getStatus() eq 1}">
                                            <div class="pending">Pending</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="completed">Completed</div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>

                                    <div class="button-flex">
                                        <c:choose>
                                            <c:when test="${app.getStatus() eq 0}">
                                                <a title="Medical Record" class="underlineHoverlogin" href="MedicalRecordServlet?appID=${app.getAppID()}"><i class="fa-regular fa-file fa-xl" style="color: #40d6a8;"></i></a>
                                                <a title="Prescription" class="underlineHoverlogin" href="PrescriptionServlet?appID=${app.getAppID()}&docID=${app.getDocID()}"><i class="fa-regular fa-clipboard fa-xl" style="color: #58d0ac;"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${AppointmentDAO.checkAppStatus(app.getAppID())}">
                                                    <a title="Medical Record" class="underlineHoverlogin" href="MedicalRecordServlet?appID=${app.getAppID()}"><i class="fa-regular fa-file fa-xl" style="color: #40d6a8;"></i></a>
                                                <a title="Prescription" class="underlineHoverlogin" href="PrescriptionServlet?appID=${app.getAppID()}&docID=${app.getDocID()}"><i class="fa-regular fa-clipboard fa-xl" style="color: #58d0ac;"></i></a>
                                                    </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                        <a title="Detail" class="underlineHoverlogin" href="#disclaimer${status.index}"><i class="fa-solid fa-bars fa-xl" style="color: #40d6a8;"></i></a>
                                    </div>                      
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>   
            </div>
        </div>
        <!------------------------ POPUP -------------------------->
        <c:set var="userID" value='${sessionScope.DocID}'/>
        <c:set var="docID" value='${DoctorDAO.getDoctorWithUserID(userID).getDocID()}'/>
        <c:forEach var="app" items="${AppointmentDAO.getDoctorAppointmentList(docID, keyword)}" varStatus="status">
            <div id="disclaimer${status.index}" class="modal-container ">
                <div class="form-popup " id="myForm" style="width: 65%; max-width: none">

                    <form action="MainController" class="form-container" method="POST" style="width: 100%">
                        <div class="flex-header" style="display: flex; justify-content: flex-end">                  
                            <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                </svg></a>
                        </div>
                        <div class="flex-header">
                            <div class="pic" >
                                <img src="img/pl 1.png" style="height: 75px;" alt=""/>
                                <h1 style="color: black">Bird Clinic</h1>                               
                            </div>
                            <h1 style="margin: 0px; display: flex; align-items: center; justify-content: center;">Appointment Form</h1>
                        </div>

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
                                    <input style="width: 150%;" type="text" value=""  placeholder="${slots[app.getSlotID()]}" class="textbox1"  readonly>
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
        </c:forEach>
        <!--                /*--------------------------------------------------------------*/-->
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
//        if (window.history.replaceState) {
//                            window.history.replaceState(null, null, "doctor_app_list");
//                        }

        function loadAppByStatus() {
            var radioButtons = document.getElementsByName("status");
            var selectedValue = "";

            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    selectedValue = radioButtons[i].value;
                    break;
                }
            }

            $.ajax({
                url: 'FilterAppServlet',
                data: {
                    status: selectedValue,
                    docID: '${docID}'
                },
                success: function (data) {
                    $('#sortByStatus').html(data);
                }
            });
        }

    </script>
</html>
