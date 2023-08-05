<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>

<%@page import="DTO.Birds"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.BirdDAO"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
        <link href="css/birdlist.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
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
                    <img src="${sessionScope.customer.image == null ? 'img/user-icon.png' : sessionScope.customer.image}" alt="Error image" id="profile-pic" />
                    <!--<label for="input-file" class="change-image-label"><i class="fa-solid fa-pen"></i></label>-->
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
                <div class="userprofileoption">
                    <i class="fa-solid fa-user"></i>
                    <h1><a class="underlineHoverlogin"  href="user-profile">Profile</a></h1>
                </div>
                <div class="userprofileoption selected">
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
                <h1 style="margin: 50px 20px;margin-bottom: 20px; font-size: 48px">Bird List</h1>
                <form action="MainController" method="POST">
                    <input type="hidden" value="${requestScope.birdstatus}" name="BirdStatus">
                    <input type="hidden" value="${requestScope.sortstatusby}" name="SortStatusBy">
                    <c:choose>
                        <c:when test="${requestScope.sortstatusby == null || requestScope.sortstatusby eq 'getAllBirds'}">
                            <button id="myButton" value="getAllBirds" name="action" style="border: none; background-color: #0E9202; float: right; margin-bottom: 10px; color: white;" class="button">View deleted birds</button>
                        </c:when>
                        <c:otherwise>
                            <button id="myButton" value="getUnhiddenBirds" name="action" style="border: none; background-color: lightgreen; float: right" class="button">View available birds</button>
                        </c:otherwise>
                    </c:choose>
                </form>
                <table class="profileinformation" style="font-size: 20px">
                    <tr class="tableheader first">
                    <form action="MainController" method="POST">
                        <input type="hidden" value="${requestScope.birdstatus}" name="BirdStatus">
                        <input type="hidden" value="${requestScope.sortstatusby}" name="SortStatusBy">
                        <td>Name<button id="myButton" value="${requestScope.sortby == null ? "getBirdsNameAsc" : requestScope.sortby}" name="action" style="border: none; background-color: initial; margin-left: 10px"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-up" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M11.5 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L11 2.707V14.5a.5.5 0 0 0 .5.5zm-7-14a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L4 13.293V1.5a.5.5 0 0 1 .5-.5z"/>
                                </svg></button></td>
                        <td>Species</td>
                        <td>Age<button id="myButton" value="${requestScope.sortageby == null ? "getBirdsAgeAsc" : requestScope.sortageby}" name="action" style="border: none; background-color: initial; margin-left: 10px"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-up" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M11.5 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L11 2.707V14.5a.5.5 0 0 0 .5.5zm-7-14a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L4 13.293V1.5a.5.5 0 0 1 .5-.5z"/>
                                </svg></button></td>
                        <td>Function</td>
                    </form>
                    </tr>
                    <c:forEach var="bird" items="${BirdDAO.getAllCustomerBirds(sessionScope.customer.userID, requestScope.keyword, (requestScope.birdstatus == null ? 'hidden' : requestScope.birdstatus))}" varStatus="status">
                        <tr class="tablerow second">
                            <td>${bird.getBird_name()}</td>
                            <td>${bird.getBird_type()}</td>
                            <td>${bird.getAge_cate()}</td>

                            <td style="display: flex; justify-content: space-between; align-items: center;">
                                <a href="#disclaimer${status.index}" class="button">Detail</a>
                                <form action="MainController" method="POST"> 
                                    <c:choose>
                                        <c:when test="${bird.getStatus() == 1}">
                                            <a href="MainController?action=hideBird&BirdStatus=${requestScope.birdstatus}&SortStatusBy=${requestScope.sortstatusby}&KeyWord=${requestScope.keyword}&birdId=${bird.getBirdID()}&act=hid" class="button" style="background-color: red; color: white;">Delete</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="MainController?action=hideBird&BirdStatus=${requestScope.birdstatus}&SortStatusBy=${requestScope.sortstatusby}&KeyWord=${requestScope.keyword}&birdId=${bird.getBirdID()}&act=unhid" class="button">Restore</a>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </td>
                        </tr>
                        <!--               /*------------------POP UP SCREEN BIRD DETAIL------------------*/-->
                        <div id="disclaimer${status.index}" class="modal-container ">
                            <div class="form-popup " id="myForm">
                                <form action="MainController" class="form-container" method="POST">
                                    <div class="flex-header" style="display: flex; justify-content: flex-end">
                                        <h1 style="flex-grow: 2;color: green; margin-right: -70px; font-size: 2em;">Bird Details</h1>
                                        <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                            </svg></a>
                                    </div>
                                    <p style="margin:. 0px auto;text-align: left; margin-left: 70px; color: rgba(102, 102, 102, 1); font-size: 18px;">Name</p>
                                    <input type="text" name="txtBirdName" placeholder="${bird.getBird_name()}" style="margin-bottom: 20px"><br/>
                                    <div class="remind  ">

                                    </div>
                                    <p style="margin: 0px auto;text-align: left; margin-left: 70px; color: rgba(102, 102, 102, 1); font-size: 18px;">Age Category</p>
                                    <select name="txtBirdAge" class="selecttextbox" style="margin-bottom: 20px">
                                        <option value="Young" ${bird.getAge_cate() == 'Young' ? 'selected' : ''}>Young</option>
                                        <option value="Growth" ${bird.getAge_cate() == 'Growth' ? 'selected' : ''}>Growth</option>
                                        <option value="Old" ${bird.getAge_cate() == 'Old' ? 'selected' : ''}>Old</option>
                                    </select>
                                    <div class="remind  ">

                                    </div>
                                    <p style="margin: 0px auto;text-align: left; margin-left: 70px; color: rgba(102, 102, 102, 1); font-size: 18px;">Species</p> 
                                    <input type="text" value="" name="txtBirdSpecies" class="textbox" placeholder="${bird.getBird_type()}" style="margin-bottom: 20px"><br/>
                                    <div class="remind  ">

                                    </div>
                                    <p style="margin: 0px auto;text-align: left; margin-left: 70px; color: rgba(102, 102, 102, 1); font-size: 18px;">Habits <span style="font-size: 14px" >(optional - write <span style="color: red">"NOTHING"</span> if you want to empty the section)</span></p> 
                                    <input type="text" value="" name="txtBirdHabit" class="textbox" placeholder="${bird.getHabit()}" style="margin-bottom: 20px"><br/>
                                    <div class="remind  ">

                                    </div>
                                    <p style="margin: 0px auto;text-align: left; margin-left: 70px; color: rgba(102, 102, 102, 1); font-size: 18px;">Personal Note <span style="font-size: 14px" >(optional - write <span style="color: red">"NOTHING"</span> if you want to empty the section)</span></p> 
                                    <input type="text" value="" name="txtBirdNote" class="textbox" placeholder="${bird.getPersonal_note()}"><br/>
                                    <div class="remind  ">

                                    </div>

                                    <input type="hidden" name="birdId" value="${bird.getBirdID()}" />
                                    <button type="submit" value="editbird" name="action" class=" second button edit-button ">Edit</button>
                                </form> 
                            </div>
                        </div>
                        <!--                /*--------------------------------------------------------------*/-->
                    </c:forEach>
                </table>
                <div class=" first"><div class="button-container"><a href="#addbirddisclaimer" class="button" id="${requestScope.anchorTrigger == null ? "" : requestScope.anchorTrigger}"><i class="fa-solid fa-plus fa-beat"></i> New Bird</a></div></div>
                <!--               /*------------------POP UP SCREEN ADD BIRD------------------*/-->
                <div id="addbirddisclaimer" class="modal-container">
                    <div class="form-popup " id="myForm">
                        <form action="MainController" class="form-container" method="POST" onsubmit="">
                            <div class="flex-header" style="display: flex; justify-content: flex-end">
                                <h1 style="flex-grow: 2;color: green; margin-right: -70px; font-size: 2em;">Add new Bird</h1>
                                <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                    <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                    </svg></a>
                            </div>
                            <p></p>
                            <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Name</p>
                            <input type="text" value="${requestScope.birdname}" name="txtBirdName" placeholder="Example: Andy" required><br/>
                            <div class="remind  ">

                            </div>
                            <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Age Category</p>
                            <select class="selecttextbox" name="txtBirdAge">
                                <option value="Young" ${requestScope.birdage == 'Young' ? 'selected' : ''}>Young</option>
                                <option value="Growth" ${requestScope.birdage == 'Growth' ? 'selected' : ''}>Growth</option>
                                <option value="Old" ${requestScope.birdage == 'Old' ? 'selected' : ''}>Old</option>
                            </select>
                            <div class="remind  ">

                            </div>
                            <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Species</p>
                            <input type="text" value="${requestScope.birdtype}" name="txtBirdSpecies" class="textbox" placeholder="Example: Sparrow" required><br/>
                            <div class="remind  ">

                            </div>
                            <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Habits (optional)</p> 
                            <input type="text" value="${requestScope.birdhabit}" name="txtBirdHabit" class="textbox" placeholder="Example: Like to eat bread crumbs"><br/>
                            <div class="remind  ">

                            </div>
                            <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Personal Note (optional)</p> 
                            <input type="text" value="${requestScope.birdnote}" name="txtBirdNote" class="textbox" placeholder="Example: Eat 3 times a day"><br/>
                            <div class="remind  ">

                            </div>
                            <button type="submit" value="addbird" name="action" class=" second button edit-button" >Save</button>
                        </form> 
                    </div>
                </div>
                <!--                /*--------------------------------------------------------------*/-->
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
            window.onload = function () {
                // Get the anchor element using its id
                var anchorElement = document.getElementById("anchorLink");

                // Check if the anchor element exists
                if (anchorElement) {
                    // Trigger a click event on the anchor element
                    anchorElement.click();
                }
            };
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
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "bird-list");
            }
        </script>
    </body>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>