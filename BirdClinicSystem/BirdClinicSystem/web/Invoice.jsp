<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/Invoice.css" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
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

        <div class="userprofile">
            <div class="leftprofile">
                <div style="background: url('img/user-background-img.jpg'); height: 120px;"></div>
                <div class="userlogo">
                    <img src="${sessionScope.customer.image == null ? 'img/user-icon.png' : sessionScope.customer.image}" alt="profile image" id="profile-pic" />
                    
                </div>
                
                <form id="profile-form" action="UploadImageServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="email" value="${sessionScope.customer.email}">
                    <input type="file" accept="image/jpeg, image/png, image/jpg" name="file" id="input-file" style="display: none">
                    <input type="submit" value="Save Image" id="choose-image-btn" style="display: none;">
                </form>
                <div class="username">
                    <h1>${sessionScope.customer.fullname}</h1>
                    <p>${sessionScope.customer.getEmail()}</p>
                </div>
                <div class="userprofileoption selected">
                    <i class="fa-solid fa-user" style="font-size: 30px;"></i>
                    <h1><a class="underlineHoverlogin"  href="user-profile">Profile</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-dove" style="font-size: 30px;"></i>
                    <h1><a class="underlineHoverlogin" href="BirdList.jsp">My Bird</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-calendar-day" style="font-size: 30px;"></i>
                    <h1><a class="underlineHoverlogin" href="MainController?action=CustomerAppointmentList">Appointment</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-right-from-bracket" style="font-size: 30px;"></i>
                    <h1><a class="underlineHoverlogin" href="#PopUpMess">Log Out</a></h1>
                </div>
            </div>

            <c:choose>
                <c:when test="${requestScope.invoice == null}">
                    <h1>This appointment has no invoice yet! Click <a href="MainController?action=CustomerAppointmentList">here</a> to go back</h1>
                </c:when>
                <c:otherwise>
                    <div class="rightprofile">
                        <h1>Invoice</h1>
                        <h2>#${requestScope.invoice.invoiceID}</h2>
                        <div class="info-title">
                            <p>Bird clinic<br>
                                birdclinic@gmail.com</p>
                            <p>999 Street A,<br>
                                District 1,<br>
                                TPHCM</p>
                        </div>
                        <div class="info-user">
                            <p>${sessionScope.customer.fullname}<br>
                                ${sessionScope.customer.email}</p>
                            <p>${sessionScope.customer.address}</p>
                        </div>

                        <table class="first-table">                 
                            <tr>
                                <td>Service</td>
                                <td>Cost</td>
                            </tr>
                        </table>
                        <table style="border: 2px solid black; height: 100px; font-size: 24px;" class="second-table">   
                            <c:forEach var="service" items="${requestScope.serviceList}">
                                <tr>
                                    <td><a class="underlineHoverlogin" href="#disclaimer">${service.servName}</a></td>
                                    <td>${service.price}</td>
                                </tr>
                                <c:set var="subtotal" value="${subtotal + service.price}"></c:set>
                            </c:forEach>
                        </table>

                        <table class="first-table">                 
                            <tr>
                                <td>Medicine Name</td>
                                <td>Quantity</td>
                                <td>Price</td>
                                <td>Cost</td>
                            </tr>
                        </table>
                        <table style="border: 2px solid black; height: 200px; font-size: 24px;" class="second-table">   
                            <c:forEach var="presDetail" items="${requestScope.prescriptionDetailList}">
                                <c:set var="medicine" value="${requestScope.medicineHashMap[presDetail.medID]}"></c:set>
                                    <tr>
                                        <td>${medicine.medName}</td>
                                    <td>${presDetail.quantity}</td>
                                    <td style="border-bottom: 2px solid;">${medicine.medPrice}</td>
                                    <fmt:formatNumber var="medicineCost" type="number" value="${presDetail.quantity * medicine.medPrice}" pattern="#,##0.00"></fmt:formatNumber>
                                    <td>${medicineCost}</td>
                                </tr>
                                <c:set var="subtotal" value="${subtotal + medicineCost}"></c:set>
                            </c:forEach>
                        </table>

                        <table style="height: 120px" class="third-table">
                            <fmt:formatNumber var="subtotal" type="number" value="${subtotal}" pattern="#,##0.00"></fmt:formatNumber>
                            <fmt:formatNumber var="tax" type="number" value="${subtotal * 10/100}" pattern="#,##0.00"></fmt:formatNumber>
                            <fmt:formatNumber var="total" type="number" value="${tax + subtotal}" pattern="#,##0.00"></fmt:formatNumber>
                                <tr>
                                    <td></td>
                                    <td>Total<br>
                                        <p style="font-size: 20px;color: #959595;">SUBTOTAL</p>
                                        <p style="font-size: 13px;color: #959595;">TAX(10%)</p>                             
                                    </td>
                                    <td>
                                    <c:out value="$${total}"></c:out>
                                        <br>
                                        <p style="font-size: 20px;color: #959595;">
                                        <c:out value="$${subtotal}"></c:out><br>
                                        </p>
                                        <p style="font-size: 20px;color: #959595;">$${tax}</p> 
                                </td>
                            </tr>
                        </table>
                        <div style="display:flex; justify-content: center; align-items: center; margin: 100px;">
                            <i class="fa-regular fa-comments fa-bounce fa-2xl" style="color: #000000; margin-right: 20px;"></i>
                            <h1><a class="underlineHover" href="#disclaimer">Feedback</a></h1>
                        </div>

                    </div>


                </c:otherwise>
            </c:choose>

        </div>
        <!--               /*------------------POP UP SCREEN BIRD DETAIL------------------*/-->
        <div id="disclaimer" class="modal-container ">
            <div class="form-popup " id="myForm">
                <form action="MainController" class="form-container" method="POST">
                    <div class="flex-header" style="display: flex; justify-content: flex-end">
                        <h1 style="flex-grow: 2; margin-right: -30px;">Feedbacks</h1>
                        <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                            </svg></a>
                    </div>
                    <div class="container">
                        <div class="post">
                            <div class="text">Thanks for rating us!</div>
                            <div class="edit">EDIT</div>
                        </div>
                        <div class="star-widget">   


                            <input type="hidden" name="appID" value="${requestScope.invoice.appointmentID}">
                            <input type="hidden" name="cusID" value="${requestScope.cusID}">

                            <input type="radio" name="rate" id="rate-5" value="5" ${rate == '5' ? 'checked' : ''}>
                            <label for="rate-5" class="fas fa-star"></label>
                            <input type="radio" name="rate" id="rate-4" value="4" ${rate == '4' ? 'checked' : ''}>
                            <label for="rate-4" class="fas fa-star"></label>
                            <input type="radio" name="rate" id="rate-3" value="3" ${rate == '3' ? 'checked' : ''}>
                            <label for="rate-3" class="fas fa-star"></label>
                            <input type="radio" name="rate" id="rate-2" value="2" ${rate == '2' ? 'checked' : ''}>
                            <label for="rate-2" class="fas fa-star"></label>
                            <input type="radio" name="rate" id="rate-1" value="1" ${rate == '1' ? 'checked' : ''}>
                            <label for="rate-1" class="fas fa-star"></label>

                            <input type="submit" value="Save" name="action">
                            <header></header>
                            <div class="textarea">
                                <textarea cols="30" placeholder="Describe your experience.." name="description">${description}</textarea>
                            </div>
                            <div class="btn">
                                <button class="fadeIn button edit-button" type="submit" value="SaveFeedback" name="action">Save</button>
                            </div>
                        </div>
                    </div>
                </form> 
            </div>
        </div>

        <!--                /*--------------------------------------------------------------*/-->        
        <header>
            <c:import url="footer.jsp"/>
        </header>
    </body>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>