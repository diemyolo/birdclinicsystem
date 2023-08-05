

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.MedicineDAO"%>
<%@page import="DTO.Medicine"%>
<%@page import="DAO.MedicineCategoryDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/DoctorMedicine.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.doctor == null}">
                <c:set var="warning" value="You need to log in as Doctor to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="DoctorHeader.jsp?medicine=aa"/>
            </c:otherwise>
        </c:choose>
        <c:set var="totalMed" value="0"></c:set>
        <c:forEach var="list" items="${MedicineDAO.getAllMedicine(requestScope.keyword, (requestScope.medcatename == null ? 'All' : requestScope.medcatename))}">
            <c:set var="totalMed" value="${totalMed + 1}" />
        </c:forEach>
        <div class="container-form" style="position: relative; top: 0px;">
            <div class="form-white">
                <div class="row1">
                    <div class="col-sm-2">
                        <h4 style="margin:0px;">Medicine</h4>
                        <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalMed} medicines</p>
                    </div>
                    <form class="col-sm-2"  action="SearchMedicineServlet" method="post">
                        <input type="hidden" name="keyword" value="${requestScope.keyword}">
                        <select name="medcatename" class="selecttextbox" style=" margin-left: 25px" onchange="this.form.submit()">
                            <option value="All" ${requestScope.medcatename == 'All' ? 'selected' : ''}>All</option>
                            <c:forEach var="med" items="${MedicineCategoryDAO.getAllMedicineCategoryName()}">
                                <option value="${med}" ${med == requestScope.medcatename ? 'selected' : ''}>${med}</option>
                            </c:forEach>     
                        </select>
                    </form>
                    <form action="MainController" class="col-sm-3" method="post">
                        <div class="row-cell">
                            <div  style="border-bottom: 1px solid;">
                                <input type="text" name="keyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 20px; border: none; width: 80%" value="${requestScope.keyword}">
                                <input type="hidden" name="medcatename" value="${requestScope.medcatename}">
                                <button value="searchMedicine" style="border:none;margin-left: 20px; background-color: white;margin-bottom: -5px;" name="action">
                                    <svg xmlns="http://www.w3.org/2000/svg" style="margin-bottom: -5px;"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="col-sm-6"> </div>
                </div>

                <div style=" margin-top:50px">
                    <table class="tablecc">                                                               
                        <tr class="table-tr1" >
                            <th>MEDICINE ID</th>
                            <th>LABEL</th>
                            <th>TYPE</th>
                            <th>CATEGORY</th>
                            <th>PRICE</th>
                            <th>DESCRIPTION</th>
                            <th>QUANTITY</th>
                            <th>VIEW</th>
                        </tr>
                        <c:forEach var="med" items="${MedicineDAO.getAllMedicine(requestScope.keyword, (requestScope.medcatename == null ? 'All' : requestScope.medcatename))}" varStatus="status">
                            <tr class="table-tr">
                                <td>${med.getMedID()}</td>
                                <td>${med.getMedName()}</td>
                                <td>${med.getMedType()}</td>
                                <td>${MedicineCategoryDAO.getMedicineCategoryByID(med.getMedCategoryID()).getMedCateName()}</td>
                                <td>$${med.getMedPrice()}</td>
                                <td>${med.getMedDescription()}</td>
                                <td>${med.getRemainingQuantity()}</td>
                                <td><a class="underlineHoverlogin" href="#disclaimer${status.index}"><i class="fa-solid fa-eye"></i></a></td>
                            </tr>
                            <!--               /*------------------POP UP SCREEN MEDICINE DETAIL------------------*/-->
                            <div id="disclaimer${status.index}" class="modal-container ">
                                <div class="form-popup " id="myForm">
                                    <form action="MainController" class="form-container" method="POST">
                                        <div class="flex-header" style="display: flex; justify-content: flex-end">
                                            <h1 style="flex-grow: 2;color: #3ED6A8; margin-right: -70px; font-size: 2.5em;">Medicine Detail</h1>
                                            <a href="#" class="modal-close"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
                                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                                </svg></a>
                                        </div>
                                        <div class="row1">
                                            <div class ="col-sm-6">
                                                <p class="fadeIn " style="margin: 0px auto; text-align: left; padding-left:26px;color: rgba(102, 102, 102, 1); font-size: 24;">Label</p>
                                                <input type="text" style="margin-left: 25px; width: 93%" name="txtMedName" placeholder="${med.getMedName()}" readonly><br/>
                                            </div>
                                            <div class ="col-sm-6" >
                                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 18px; color: rgba(102, 102, 102, 1); font-size: 24;">Type</p>
                                                <input type="text" name="txtMedType"  placeholder="${med.getMedType()}" readonly><br/>
                                            </div>                       
                                        </div>
                                        <div class="row1">
                                            <div class ="col-sm-6">
                                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left:26px;color: rgba(102, 102, 102, 1); font-size: 24;">Price</p>
                                                <div style="display:flex;">
                                                    <div style="display: flex;align-items: center; justify-content: center; margin-left: 25px;width: 60px; background-color: #85bb65; border-radius: 8px 0px 0px 8px;"><i class="fa-solid fa-dollar-sign fa-xl" style="color:white"></i></div>
                                                    <input type="text" name="txtMedPrice" placeholder="${med.getMedPrice()}" readonly><br/>  
                                                </div>

                                            </div>
                                            <div class ="col-sm-6" >
                                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 18px; color: rgba(102, 102, 102, 1); font-size: 24;">Quantity</p>
                                                <input type="text" name="txtRemainingQuantity"  placeholder="${med.getRemainingQuantity()}"readonly><br/>
                                            </div>                       
                                        </div>
                                        <div class="row1">
                                            <div class="col-sm-6">
                                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 26px; color: rgba(102, 102, 102, 1);margin-top: 7px">Medicine Category</p>
                                                <input style="width: 95%; margin-left: 25px;" type="text" name="txtMedCateName"  placeholder="${MedicineCategoryDAO.getMedicineCategoryByID(med.getMedCategoryID()).getMedCateName()}" readonly><br/>
                                            </div>                
                                        </div>
                                        <br>
                                        <div class="redem fadeIn">
                                            <p class="fadeIn " style="margin: 0px auto;text-align: left;margin-left: 40px; color: rgba(102, 102, 102, 1); font-size: 24;">Description</p> 
                                            <input type="text" value="" name="txtMedDescription" placeholder="${med.getMedDescription()}"readonly><br/>
                                        </div>

                                        <div class="remdem fadeIn ">
                                            <p class="fadeIn " style="margin: 0px auto;text-align: left;margin-left: 40px;  color: rgba(102, 102, 102, 1); font-size: 24;">Drug Uses</p> 
                                            <textarea type="text" value="" name="txtDrugUse" class="textbox" placeholder="${med.getDrugUse()}"readonly></textarea><br/>
                                        </div>

                                        <div class="redem fadeIn ">
                                            <p class="fadeIn " style="margin: 0px auto;text-align: left; margin-left: 40px; color: rgba(102, 102, 102, 1); font-size: 24;">Side Effects</p>
                                            <textarea type="text" name="txtSideEffect" class="textbox"  placeholder="${med.getSideEffect()}"readonly></textarea><br/>
                                        </div>

                                        <div class="redem fadeIn " style="padding-bottom: 50px;">
                                            <p class="fadeIn " style="margin: 0px auto;text-align: left;margin-left: 40px;  color: rgba(102, 102, 102, 1); font-size: 24;">Composition</p> 
                                            <textarea style="height:150px ;" type="text" value="" name="txtComposition" class="textbox" placeholder="${med.getComposition()}"readonly></textarea><br/>
                                        </div>
                                    </form> 
                                </div>
                            </div>
                            <!--                /*--------------------------------------------------------------*/-->
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div><!-- -->
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "Doctor_MedicineList.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
