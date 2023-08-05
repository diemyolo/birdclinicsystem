<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.MedicineDAO"%>
<%@page import="DAO.MedicineCategoryDAO"%>
<%@page import="DTO.Medicine"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/AddMedicine.css" rel="stylesheet">
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
                <c:import url="StaffHeader.jsp?medicine=a"/>
            </c:otherwise>
        </c:choose>

        <div class="container-form">
            <%@include file="NotificationMess.jsp" %>
            <div class="form-white">              
                <!--               /*------------------ADD MEDICINE SCREEN------------------*/-->
                <form action="MainController" class="form-container" method="POST">
                    <div class="flex-header" style="display: flex; justify-content: flex-end">
                        <h1 style="flex-grow: 2;color: #3ED6A8; margin-bottom: 50px; font-size: 2.5em;">Add New Medicine</h1>                              
                    </div>
                    <div class="row1">
                        <div class ="col-sm-6">
                            <p class="fadeIn " style="margin: 0px auto; padding: 0px; text-align: left; color: rgba(102, 102, 102, 1)">Label</p>
                            <input type="text"  style="width: 100%;" name="txtMedName" value="${requestScope.MedName}" placeholder="Example: Doxycycline" required><br/>
                            <p style="margin: 0px; text-align: left; color: rgba(102, 102, 102, 1); font-size: 14px; color: red; padding-left: 0px">${requestScope.WARNINGNAME}</p>
                        </div>
                        <div class ="col-sm-6" >
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; padding: 0px; color: rgba(102, 102, 102, 1)">Type</p>
                            <input type="text" name="txtMedType"  value="${requestScope.MedType}" placeholder="Example: Pills" required><br/>
                            <c:if test="${requestScope.WARNINGNAME != null}">
                                <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 14px; color: red"> </p>
                            </c:if>
                        </div>                       
                    </div>
                    <div class="row1">
                        <div class ="col-sm-6">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; padding: 0px; color: rgba(102, 102, 102, 1)">Price</p>
                            <div style="display:flex;">
                                <div style="display: flex;align-items: center; justify-content: center; width: 60px; background-color: #00db5f; border-radius: 8px 0px 0px 8px;"><i class="fa-solid fa-dollar-sign" style="color: white;"></i></div>
                                <input type="text" name="txtMedPrice" value="${requestScope.MedPrice}" placeholder="Example: 69.69" pattern="[0-9]+(\.[0-9]+)?" title="Please enter a valid price" required><br/>  
                            </div>

                        </div>
                        <div class ="col-sm-6" >
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; padding: 0px; color: rgba(102, 102, 102, 1)">Quantity</p>
                            <input type="text" name="txtRemainingQuantity" value="${requestScope.RemainQuantity}" pattern="[0-9]+(\.[0-9]+)?" title="Please enter a valid quantity" placeholder="Example: 99" required><br/>
                        </div>                     
                    </div>

                    <div class="row1">
                        <div class="col-sm-6">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; padding: 0px; color: rgba(102, 102, 102, 1)">Medicine Category</p>
                            <select name="txtMedCategory" class="selecttextbox">
                                <c:forEach var="med" items="${MedicineCategoryDAO.getAllMedicineCategoryName()}">
                                    <option value="${med}" ${med == requestScope.MedCategory ? 'selected' : ''}>${med}</option>
                                </c:forEach>                           
                            </select>
                            <a class="button" style="padding: 15px 20px;" href="#addcategorydisclaimer" id="${requestScope.anchorTrigger == null ? "" : requestScope.anchorTrigger}"><i class="fa-solid fa-plus fa-beat"></i></a>
                        </div>
                    </div>
                    <br>
                    <div class="col-sm-12">
                        <div class="redem fadeIn">
                            <p class="fadeIn " style="margin: 0px auto;padding: 0px;text-align: left; color: rgba(102, 102, 102, 1);">Description</p> 
                            <input type="text" name="txtMedDescription" value="${requestScope.MedDes}" placeholder="Example: Infection Treatment" required><br/>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="remdem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;padding: 0px;text-align: left;color: rgba(102, 102, 102, 1); margin-top: 17px">Drug Uses</p> 
                            <textarea type="text" name="txtDrugUse" class="textbox" placeholder="Example: Used to treat bacterial infection" required>${requestScope.DrugUse}</textarea><br/>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="redem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;padding: 0px;text-align: left;  color: rgba(102, 102, 102, 1); margin-top: 17px">Side Effects</p>
                            <textarea type="text" name="txtSideEffect" class="textbox" placeholder="Example: Include nausea, vomiting" required>${requestScope.SideEffect}</textarea><br/>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="redem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;padding: 0px;text-align: left;color: rgba(102, 102, 102, 1); margin-top: 17px">Composition</p> 
                            <textarea type="text" name="txtComposition" class="textbox" placeholder="Example: Used together with certain tick-bone illness" required>${requestScope.Composition}</textarea><br/>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="redem fadeIn" style="display: flex; justify-content: center;">
                            <input type="hidden" value="${med.getMedID()}" name="txtMedId">
                            <button type="submit" value="addMedicine" name="action" class="fadeIn second button edit-button ">Save</button>
                        </div>
                    </div>
                </form> 
            </div>
        </div>
        <!--               /*------------------POP UP SCREEN ADD CATEGORY------------------*/-->
        <div id="addcategorydisclaimer" class="modal-container">
            <div class="form-popup" id="myForm">
                <form action="MainController" class="form-container" method="POST" onsubmit="">
                    <div class="flex-header" style="display: flex; justify-content: flex-end">
                        <h1 style="flex-grow: 2;color: green; margin-right: -70px; font-size: 2em;">Add Medicine Category</h1>
                        <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                            </svg></a>
                    </div>
                    <p></p>
                    <p style="margin: 0px auto; text-align: left; color: rgba(102, 102, 102, 1)">Medicine Category ID</p>
                    <input type="text" value="${MedicineCategoryDAO.getNextMedicineCategoryID()}" readonly><br/>
                    <div class="remind  ">

                    </div>
                    <p style="margin: 0px auto; text-align: left; color: rgba(102, 102, 102, 1)">Medicine Category Name</p>
                    <input type="text" value="${requestScope.MedCateName}" name="txtMedicineCateName" placeholder="Example: Vaccination" required><br/>
                    <c:if test="${requestScope.WARNINGCATEGORY != null}">
                        <p style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 14px; color: red">${requestScope.WARNINGCATEGORY}</p>
                    </c:if>
                    <button value="Add Med Category" name="action" class="second button edit-button">Save</button>
                </form>
            </div>
        </div>
        <!--                /*--------------------------------------------------------------*/-->
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
        </script>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "Staff_AddMedicine.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
