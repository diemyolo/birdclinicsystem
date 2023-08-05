<%-- 
    Document   : ADB_HomePage
    Created on : Jul 5, 2023, 2:37:46 PM
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
        <link rel="stylesheet" href="DashBoardCSS/style.css" />
        <link rel="stylesheet" href="DashBoardCSS/medicine.css" />
        <!--        Pop-UP CSS-->
        <link href="css/PopUpMess.css" rel="stylesheet">
        <!-- Boxicons CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />


    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.admin == null}">
                <c:set var="warning" value="You need to log in as Admin to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
        </c:choose>
        <div class="sidebar">
            <div class="logo-details">              
                <img class="bx bxl-c-plus-plus" src="img/pl 1.png" height="50px" style="margin: 5px;"  alt=""/>
                <span class="logo_name">BirdClinic</span>
            </div>
            <ul class="nav-links">
                <li>
                    <a href="MainController?action=InvoiceList" >
                        <i class="bx bx-grid-alt"></i>
                        <span class="links_name">Dashboard</span>
                    </a>
                </li>
                <span class="dropdown-btn"><i class="fa-regular fa-user" style=" min-width: 60px; margin-left: 6px;font-size: 18px;color: rgba(11, 183, 131, 1); "><span class="links_name" style="margin-left: 22px;font-weight: 400;white-space: nowrap; color: black">Users</span></i></span>
                <span class="dropdown-container">
                    <div class="fadeIn first" style="padding: 10px;">                           
                        <a class="hover_div" href="MainController?action=CustomerList"><i class="fa-solid fa-user-pen " style="margin: 5px; margin-right: 13px; color: black"></i>Customers</a>
                    </div>
                    <div class="fadeIn second" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=StaffList"><i class="fa-solid fa-user-gear" style="margin: 5px; margin-right: 13px; color: black"></i>Staffs</a>
                    </div>
                    <div class="fadeIn third" style="padding: 10px;">
                        <a class="hover_div" href="MainController?action=DoctorList"><i class="fa-solid fa-user-doctor fa-lg" style="margin: 5px; margin-right: 16px; ;color: black"></i>Doctors</a>
                    </div>
                </span>
                <li>
                    <a href="MainController?action=AppointmentList" >
                        <i class="fa-regular fa-calendar-days" style="color: #0bb783;"></i>
                        <span class="links_name">Appointment</span>
                    </a>
                </li>
                <li>
                    <a href="ADB_Medicine.jsp" class="active">
                        <i class="fa-solid fa-capsules" style="color: #0db783;"></i>
                        <span class="links_name">Medicine</span>
                    </a>
                </li>
                <li>
                    <a href="ADB_Profile.jsp">
                        <i class="fa-regular fa-circle-user"></i>
                        <span class="links_name">My Profile</span>
                    </a>
                </li>


                <li class="log_out">
                    <a href="#LogOut">
                        <i class="bx bx-log-out"></i>
                        <span class="links_name">Log out</span>
                    </a>
                </li>
            </ul>

        </div>
        <section class="home-section">
            <nav style="background: #3ED6A8">
                <div class="sidebar-button">
                    <i class="bx bx-menu sidebarBtn" style="cursor: pointer"></i>
                    <span class="dashboard" style="color: white;">Dashboard</span>
                </div>
                <div class="profile-details">
                    <img src="img/user-profile.png" alt="" />
                    <span class="admin_name">${sessionScope.adminname}</span>    
                </div>
            </nav>

            <div class="home-content">
                <div class="sales-boxes">
                    <div class="recent-sales box">
                        <div class="row1">
                            <c:set var="totalMed" value="0"></c:set>
                            <c:forEach var="list" items="${MedicineDAO.getAllMedicine(requestScope.keyword, (requestScope.medcatename == null ? 'All' : requestScope.medcatename))}">
                                <c:set var="totalMed" value="${totalMed + 1}" />
                            </c:forEach>
                            <div class="col-sm-2">
                                <h4 style="margin:0px;">Medicine</h4>
                                <p style="margin:0px; color:rgba(201, 202, 202, 1);">Show ${totalMed} medicines</p>
                            </div>
                            <div class="col-sm-4"> </div>
                            <form class="col-sm-3" action="SearchMedicineServlet" method="post">
                                <input type="hidden" name="keyword" value="${requestScope.keyword}">
                                <select name="medcatename" class="selecttextbox " style=" margin-left: 25px" onchange="this.form.submit()">
                                    <option value="All" ${requestScope.medcatename == 'All' ? 'selected' : ''}>All</option>
                                    <c:forEach var="med" items="${MedicineCategoryDAO.getAllMedicineCategoryName()}">
                                        <option value="${med}" ${med == requestScope.medcatename ? 'selected' : ''}>${med}</option>
                                    </c:forEach>     
                                </select>
                            </form>
                            <form class="col-sm-2" action="MainController" method="post">
                                <div class="row-cell">
                                    <div cstyle="border-bottom: 2px solid; width: 25%">
                                        <input type="text" name="keyword" placeholder="Search..." class="border-revmove" style="outline: none; font-size: 20px; background-color: initial; padding-bottom: 10px; border: none; width: 80%" value="${requestScope.keyword}">
                                        <input type="hidden" name="medcatename" value="${requestScope.medcatename}">
                                        <button value="searchMedicine" style="border:none;margin-left: 20px; background-color: white;margin-bottom: -5px;" name="action">
                                            <svg xmlns="http://www.w3.org/2000/svg" style="margin-bottom: -5px;"  width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </form>


                        </div>
                        <table border="1" width="100%" >                                
                            <tbody>
                                <tr class="table-cus">
                                    <th>MEDICINE ID</th>
                                    <th>LABEL</th>
                                    <th>TYPE</th>
                                    <th>CATEGORY</th>
                                    <th>PRICE</th>
                                    <th>DESCRIPTION</th>
                                    <th>QUANTITY</th>
                                    <th>EDIT</th>
                                </tr>
                                <c:forEach var="med" items="${MedicineDAO.getAllMedicine(requestScope.keyword, (requestScope.medcatename == null ? 'All' : requestScope.medcatename))}" varStatus="status">
                                    <tr>
                                        <td>${med.getMedID()}</td>
                                        <td>${med.getMedName()}</td>
                                        <td>${med.getMedType()}</td>
                                        <td>${MedicineCategoryDAO.getMedicineCategoryByID(med.getMedCategoryID()).getMedCateName()}</td>
                                        <td>$${med.getMedPrice()}</td>
                                        <td>${med.getMedDescription()}</td>
                                        <td>${med.getRemainingQuantity()}</td>

                                        <td style="text-align: center;">
                                            <a class="button" href="#PopUpMess${status.index}">
                                                <i class="fa-solid fa-pen-to-square" style="color: #000000;"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>    
                    </div>
                </div>
            </div>
        </section> 
        <!--Pop up Medicine-->
        <c:forEach var="med" items="${MedicineDAO.getAllMedicine(requestScope.keyword, (requestScope.medcatename == null ? 'All' : requestScope.medcatename))}" varStatus="status">
            <div id="PopUpMess${status.index}" class="modal-container ">
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
                                <input type="text" style="margin-left: 25px; width: 400px;" name="txtMedName" placeholder="${med.getMedName()}"><br/>
                            </div>
                            <div class ="col-sm-6" >
                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 18px; color: rgba(102, 102, 102, 1); font-size: 24;">Type</p>
                                <input type="text" name="txtMedType"  placeholder="${med.getMedType()}"><br/>
                            </div>                       
                        </div>
                        <div class="row1">
                            <div class ="col-sm-6">
                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left:26px;color: rgba(102, 102, 102, 1); font-size: 24;">Price</p>
                                <div style="display:flex;">
                                    <div style="display: flex;align-items: center; justify-content: center; margin-left: 25px;width: 60px; background-color: #85bb65; border-radius: 8px 0px 0px 8px;"><i class="fa-solid fa-dollar-sign fa-xl" style="color: white"></i></div>
                                    <input type="text" name="txtMedPrice" style="width: 340px"  placeholder="${med.getMedPrice()}" pattern="[0-9]+(\.[0-9]+)?" title="Please enter a valid price"><br/>
                                </div>

                            </div>
                            <div class ="col-sm-6" >
                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 18px; color: rgba(102, 102, 102, 1); font-size: 24;">Quantity</p>
                                <input type="text" name="txtRemainingQuantity" placeholder="${med.getRemainingQuantity()}" pattern="[0-9]+(\.[0-9]+)?" title="Please enter a valid quantity"><br/>
                            </div>                       
                        </div>
                        <div class="row1">
                            <div class="col-sm-6">
                                <p class="fadeIn " style="margin: 0px auto;text-align: left; padding-left: 26px; color: rgba(102, 102, 102, 1)">Medicine Category</p>
                                <select name="txtMedCategory" class="selecttextbox">
                                    <c:forEach var="medcate" items="${MedicineCategoryDAO.getAllMedicineCategoryName()}">
                                        <option value="${medcate}" ${medcate == MedicineCategoryDAO.getMedicineCategoryByID(med.getMedCategoryID()).getMedCateName() ? 'selected' : ''}>${medcate}</option>
                                    </c:forEach>                           
                                </select>
                            </div>                
                        </div>
                        <br>
                        <div class="redem fadeIn">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Description</p> 
                            <input type="text" value="" name="txtMedDescription" placeholder="${med.getMedDescription()}"><br/>
                        </div>

                        <div class="remdem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Drug Uses</p> 
                            <textarea type="text" value="" name="txtDrugUse" class="textbox" placeholder="${med.getDrugUse()}"></textarea><br/>
                        </div>

                        <div class="redem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left; color: rgba(102, 102, 102, 1); font-size: 24;">Side Effects</p>
                            <textarea type="text" name="txtSideEffect" class="textbox"  placeholder="${med.getSideEffect()}"></textarea><br/>
                        </div>

                        <div class="redem fadeIn ">
                            <p class="fadeIn " style="margin: 0px auto;text-align: left;color: rgba(102, 102, 102, 1); font-size: 24;">Composition</p> 
                            <textarea style="height: ;" type="text" value="" name="txtComposition" class="textbox" placeholder="${med.getComposition()}"></textarea><br/>
                        </div>

                        <div class="redem fadeIn ">
                            <input type="hidden" value="${med.getMedID()}" name="txtMedId">
                            <button type="submit" value="editMedicine" name="action" class="fadeIn second button edit-button ">Edit</button>
                        </div>

                    </form> 
                </div>
            </div>
        </c:forEach>
        <!--            // Logout confirm-->
        <div id="LogOut" class="modal-container ">
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
        <script>
            let sidebar = document.querySelector(".sidebar");
            let sidebarBtn = document.querySelector(".sidebarBtn");
            sidebarBtn.onclick = function () {
                sidebar.classList.toggle("active");
                if (sidebar.classList.contains("active")) {
                    sidebarBtn.classList.replace("bx-menu", "bx-menu-alt-right");
                } else
                    sidebarBtn.classList.replace("bx-menu-alt-right", "bx-menu");
            }

            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;
            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        </script>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "ADB_Medicine.jsp");
            }
        </script>
    </body>
</html>
