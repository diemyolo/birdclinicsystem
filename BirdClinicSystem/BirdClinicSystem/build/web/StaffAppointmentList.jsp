

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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.staff == null}">
                <c:set var="warning" value="You need to log in as Staff to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="StaffHeader.jsp?schedule=a"/>
            </c:otherwise>
        </c:choose>
        <c:set var="updateStatus" value="${AppointmentDAO.updateAppStatus()}"/>
        <div class="container-form">
            <div class="form-white">
                <form action="MainController" class="row1" method="post">
                    <c:set var="totalAppointments" value="0"></c:set>
                    <c:forEach var="list" items="${requestScope.list}">
                        <c:set var="totalAppointments" value="${totalAppointments + 1}" />
                    </c:forEach>
                    <div class="col-sm-2">
                        <h4 style="margin:0px;">Appointment</h4>
                        <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalAppointments} appointments</p>
                    </div>

                    <div class="col-sm-2" style="border-bottom: 1px solid">
                        <input type="text" name="txtkeyword" placeholder="Search..." value="${requestScope.keyword}" class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 10px; border: none; width: 80%">
                        <button value="AppointmentList" style="border:none; background-color: white;" name="action">
                            <svg xmlns="http://www.w3.org/2000/svg"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                            </svg>
                        </button>
                    </div>
                    <select name="txtsearchby" class="selecttextbox col-sm-2" style="width: 30%; margin-left: 25px">
                        <option value="appid" ${requestScope.searchby == 'appid' ? 'selected' : ''}>App ID</option>
                        <option value="cusname" ${requestScope.searchby == 'cusname' ? 'selected' : ''}>Customer Name</option>
                    </select>
                    <div class="col-sm-2">
                        <div class="form-check">
                            <label class="form-check-label col-sm-6" style="margin:0px; padding: 0px ;font-size: 20px; color:red" for="defaultCheck1">Pending</label>
                            <input class="form-check-input col-sm-3" style="margin:0px; padding: 0px; height: 50%; margin-top: 7px"  type="checkbox" value="pending" id="defaultCheck1" name="txtpending" ${requestScope.Pending == 'pending' ? 'checked' : ''}>

                        </div>
                        <div class="form-check">
                            <label class="form-check-label col-sm-6" style="margin:0px; padding: 0px; font-size: 20px;color:green " for="defaultCheck1">Completed</label>
                            <input class="form-check-input col-sm-3" style="margin:0px; padding: 0px; height: 50%; margin-top: 7px" type="checkbox" value="completed" id="defaultCheck1" name="txtcompleted" ${requestScope.Completed == 'completed' ? 'checked' : ''}>                                
                        </div>
                    </div>
                    <div class="col-sm-2" >
                        <div class="box-shade" style="width: 55%; margin-right: 10px; margin-bottom: 10px;">
                            <p style="margin: 0px;margin-bottom: -8px; padding: 0px; font-size: 15px; color: #109CF1;">Start with</p>
                            <input type="Date" class="Date-box" name="txtstartDate" value="${requestScope.startdate}"> 
                        </div>                      
                        <div class="box-shade" style="width: 55%">
                            <p style="margin: 0px; margin-bottom: -8px; padding: 0px; font-size: 15px; color: #109CF1;">End with</p>
                            <input type="Date" class="Date-box" name="txtendDate" value="${requestScope.enddate}">
                        </div> 
                    </div>


                </form>  
                <div style=" margin-top:50px">
                    <table class="tablecc">                                                               
                        <tr class="table-tr1" >
                            <td>APPOINTMENT ID</td>
                            <td>CUSTOMER NAME</td>
                            <td>DATE</td>
                            <td>SERVICES</td>
                            <td>DOCTOR NAME</td>
                            <td>STATUS</td>
                            <td></td>
                        </tr>
                        <c:forEach var="list" items="${requestScope.list}" varStatus="status">
                            <tr class="table-tr">
                                <td>${list.getAppID()}</td>
                                <td>${list.getCustomerName()} </td>
                                <td style="width: 15%">
                                    <h5 style="margin:0px; font-size: 20px;color:rgba(62, 214, 168, 1);">${list.getDate()}</h5>
                                    <p style="margin:0px; font-size: 17px; color:rgba(201, 202, 202, 1);">${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}</p>
                                </td>
                                <td>
                                    <div>${list.getServiceName()}</div>
                                </td>
                                <td>${list.getDoctorName()}</td>
                                <c:if test="${list.getStatus() eq 1}">
                                    <td><div class="pending"><a>Pending</a></div></td>  
                                </c:if>
                                <c:if test="${list.getStatus() eq 0}">
                                    <td><div class="completed">Completed</div></td>
                                </c:if>
                                <td><a class="underlineHoverlogin" href="#disclaimer${status.index}"><i class="fa-solid fa-bars"></i></a></td>
                            </tr>
                        </c:forEach> 
                    </table>
                </div>
            </div>
        </div>
        <!------------------------ POPUP -------------------------->
        <c:forEach var="list" items="${requestScope.list}" varStatus="status">
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
                                <img src="img/pl 1.png" style="height: 75px;margin-right: 10px;" alt=""/>
                                <h1 style="color: black">Appointment Form</h1>
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
                                    <input style="width: 150%;" type="text" value=""  placeholder="${list.getBirdName()}" class="textbox1" readonly>
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Mobile number:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${list.getPhone()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Address:</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${list.getAddress()}" class="textbox1" readonly>
                            </div>
                            <div class="row1">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Doctor In Charge:</div>
                                    <input style="width: 140%" class="textbox1" type="text" value=""  placeholder="${list.getDoctorName()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">                              
                                </div>                          
                            </div>

                            <div class="row1" style="background-color: white">
                                <div class="col-sm-6 flexing-center">
                                    <div style="width: 100%">Scheduled date:</div>
                                    <input style="width: 141%;" class="textbox1" type="text" value=""  placeholder="${list.getDate()}" readonly>
                                </div>                     
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5 flexing-center">
                                    <div style="width: 90%">Slot Time:</div>
                                    <input style="width: 150%;" type="text" value=""  placeholder="${list.getStartTime().substring(0,5)}-${list.getEndTime().substring(0,5)}" class="textbox1"  readonly>
                                </div>                           
                            </div>
                            <div class="row1">
                                <div class="col-sm-2" style="width: 100%; padding: 5px; margin-left: 5px;">Service(s):</div>
                                <input style="width: 79%;" type="text" value=""  placeholder="${list.getServiceName()}" class="textbox1" readonly>
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
        <!--                /*--------------------------------------------------------------*/-->
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, "MainController?action=AppointmentList");
        }
    </script>
    </body>
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
