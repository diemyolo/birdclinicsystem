<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>
<%@page import="DTO.Doctor"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.DoctorDAO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/docliststyle.css" rel="stylesheet">
    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.customer != null}">
                <c:import url="headerUser.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="header.jsp"/>
            </c:otherwise>
        </c:choose>

        <div class="blogbanner">
            <h1 style="font-family: Arial;">Meet our teams</h1>
            <h2 style="font-family: Arial;">Taking care of your feathered friends</h2>
        </div>

        <!-- Change page code -->
        <div id="pageChangeBar">
            <nav aria-label="Page navigation example" class="subPageChangeBar" style="margin: 0;">
                <ul class="pagination justify-content-center">
                    <c:if test="${requestScope.page == 1  || requestScope.page == null}">
                        <li class="page-item">
                            <a class="page-link" style="padding: 5px 10px !important;color: #1B9C85" href="MainController?action=viewPaginatedDoctor&page=${requestScope.numOfSearchPages}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${requestScope.page > 1}">
                        <li class="page-item">
                            <a class="page-link" style="padding: 5px 10px !important;color: #1B9C85" href="MainController?action=viewPaginatedDoctor&page=${requestScope.page-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <%
                        ArrayList<Doctor> list = (ArrayList<Doctor>) request.getAttribute("fullList");
                        int totalDoctors = list.size();
                        int element = 3;
                        float numOfSearchPages = (float) totalDoctors / element;
                    %>

                    <%for (int i = 1; i <= (int) Math.ceil(numOfSearchPages); i++) {%>
                    <li class="page-item "><a class="page-link " style="padding:5px 10px !important;color: #1B9C85" 
                                              href="MainController?action=viewPaginatedDoctor&page=<%=i%>"><%=i%></a></li>
                        <% }%>
                    <c:if test="${requestScope.page < requestScope.numOfSearchPages}">
                        <li class="page-item">
                            <a class="page-link" style="padding:5px 10px !important;color: #1B9C85" href="MainController?action=viewPaginatedDoctor&page=${requestScope.page + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${requestScope.page == requestScope.numOfSearchPages}">
                        <li class="page-item">
                            <a class="page-link" style="padding:5px 10px !important;color: #1B9C85" href="MainController?action=viewPaginatedDoctor&page=1" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                </ul>
            </nav>
        </div>

        <!--doctor list-->
        <c:if test="${requestScope.paginatedList == null}">
            <c:forEach var="doctor" items="${requestScope.fullList}">
                <div class="doctor-introduction">
                    <img src="${doctor.getImage()}" alt="beautiful-doctor"/>
                    <div class="doccontent">
                        <div style="display: flex">
                            <div style="height: 250px">
                                <h1 style="font-weight: bold; color: green">${doctor.getFullname()}</h1>
                                <p style="font-weight: bold;">${doctor.getEmail()}</p>
                                <p>${doctor.docDes}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${requestScope.paginatedList != null}">
            <c:forEach var="doctor" items="${requestScope.paginatedList}">
                <div class="doctor-introduction">
                    <img src="${doctor.getImage()}" alt="beautiful-doctor"/>
                    <div class="doccontent">
                        <div style="display: flex">
                            <div style="height: 250px">
                                <h1 style="font-weight: bold; color: green">${doctor.getFullname()}</h1>
                                <p style="font-weight: bold;">${doctor.getEmail()}</p>
                                <p>${doctor.docDes}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <div style="margin-bottom: 100px;"></div>
        <footer>
            <c:import url="footer.jsp"/>
        </footer>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
