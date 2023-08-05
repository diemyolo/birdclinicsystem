<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta charset="UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/userprofilestyle.css" rel="stylesheet">
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
                    <label for="input-file" class="change-image-label"><i class="fa-solid fa-pen"></i></label>
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
                    <i class="fa-solid fa-user"></i>
                    <h1><a class="underlineHoverlogin"  href="user-profile">Profile</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-dove"></i>
                    <h1><a class="underlineHoverlogin" href="BirdList.jsp">My Bird</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-calendar-day"></i>
                    <h1><a class="underlineHoverlogin" href="MainController?action=CustomerAppointmentList">Appointment</a></h1>
                </div>
                <div class="userprofileoption">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <h1><a class="underlineHoverlogin" href="#PopUpMess">Log Out</a></h1>
                </div>
            </div>
            <div class="rightprofile">
                <%@include file="NotificationMess.jsp" %>
                <h1 style="margin: 50px 20px;font-size: 48px">Profile</h1>
                <table class="profileinformation">
                    <tr class="tablerow">
                        <td class="rowheader" >Email</td>
                        <td class="flex-table" style="margin-bottom: 20px;"><input  type="text" value="" name="txtEmail" class="textbox" placeholder="${sessionScope.customer.email}" readonly></td>
                        <td></td>
                    </tr>
                    <tr class="tablerow">
                    <form action="MainController" method="POST">
                        <td class="rowheader">Personal Name</td>
                        <td><input type="text" value="" name="txtFullName" class="textbox" placeholder="${sessionScope.customer.fullname}"></td>
                        <td class="flex-table"><button value="ChangeCustomerProfile" name="action" class="button">Change</button></td>
                    </form>
                    </tr>
                    <tr class="tablerow">
                    <form action="MainController" method="POST">
                        <td class="rowheader">Gender</td>
                        <td >
                            <select name="txtGender" class="gender" >
                                <option value="Male" <c:if test="${sessionScope.customer.gender == 'Male'}"> selected </c:if> >Male</option>
                                <option value="Female" <c:if test="${sessionScope.customer.gender == 'Female'}"> selected </c:if> >Female</option>
                                <option value="Other" <c:if test="${sessionScope.customer.gender == 'Other'}"> selected </c:if> >Other</option>
                                </select>
                            </td>                                                                      
                            <td class="flex-table"><button value="ChangeCustomerProfile" name="action" class="button">Change</button></td>
                        </form>
                        </tr>

                        <tr class="tablerow">
                        <form action="MainController" method="POST">
                            <td class="rowheader">Password</td>
                            <td>
                                <span class="textbox">
                                    **********
                                </span>
                            </td>
                            <td class="flex-table">
                                <input type="hidden" name="roleID" value="${sessionScope.customer.roleID}">
                            <button value="Go to Change Password" name="action" class="button">Change</button>
                        </td>
                    </form>
                    </tr>
                    <tr class="tablerow">
                    <form action="MainController" method="POST">
                        <td class="rowheader">Phone</td>
                        <td><input type="text" value="" name="txtPhone" class="textbox" placeholder="${sessionScope.customer.phone}"></td>
                        <td class="flex-table">
                            <button value="ChangeCustomerProfile" name="action" class="button">Change</button>
                        </td>
                    </form>
                    </tr>
                    <tr class="tablerow">
                    <form action="MainController" method="POST">
                        <td class="rowheader">Address</td>
                        <td><input type="text" value="" name="txtAddress" class="textbox" placeholder="${sessionScope.customer.address}"></td>
                        <td class="flex-table"><button value="ChangeCustomerProfile" name="action" class="button">Change</button></td>
                    </form>
                    </tr>
                    <tr class="tablerow">
                    <form action="MainController" method="POST">
                        <td class="rowheader">Birth Date</td>
                        <td><input type="date" value="${sessionScope.customer.birthDate}" name="txtBirthDate" style="text-decoration: none;color:grey; border: none; outline: none; margin-left: 50px;"></td>
                        <td class="flex-table"><button value="ChangeCustomerProfile" name="action" class="button">Change</button></td>
                    </form>
                    </tr>
                </table>

            </div>
        </div>
        <div id="PopUpMess" class="modal-container ">

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

        <header>
            <c:import url="footer.jsp"/>
        </header>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "UserProfile.jsp");
            }
        </script>
    </body>
    <script>
        const inputFile = document.getElementById("input-file");
        const chooseImageBtn = document.getElementById("choose-image-btn");
        const updateImageLabel = document.querySelector(".change-image-label");

        inputFile.addEventListener("change", () => {
            if (inputFile.files.length > 0) {
                chooseImageBtn.style.display = "block";
            } else {
                chooseImageBtn.style.display = "none";
            }
        });
    </script>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
