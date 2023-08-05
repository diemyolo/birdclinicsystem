<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>

<%@page import="DAO.ServiceDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Services"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/serviceList.css" rel="stylesheet">
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.customer == null}">
                <c:import url="header.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="headerUser.jsp"/>
            </c:otherwise>
        </c:choose>

        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel1 pictureCarusel ">
                    <h1 style="font-weight: 700;">Our Service</h1>
                    <p style="font-size: 25px;">Taking care of your feathered friends</p>
                </div>
            </div>
        </div>

        <form action="MainController" method="post" class="search">
            <input type="text" name="keyword" placeholder="Search" class="border-revmove" style="outline: none; font-size: 25px;" value="${param.keyword}">
            <button value="searchService" name="action" >
                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
            </button>
        </form>
        <c:choose>
            <c:when test="${not empty requestScope.list}">
                <div class="service-block">
                    <div class="service-content-page appear contain">
                        <c:forEach var="serv" items="${requestScope.list}">
                            <div class="catagories item" style="background-color: #F9F5F6; color: black; box-shadow: 2px 6px 10px rgba(0,0,0,0.5)">
                                <img src="${serv.serv_img}" alt=""/>
                                <div class="cata-content" style="padding: 20px">
                                    <div class="line1" style="border: 6px solid #31A308;"></div>
                                    <h2><a class="underlineHoverlogin" style="text-decoration: none;" href="${serv.servName}.jsp">${serv.servName}</a></h2>
                                    <p>${serv.ser_description}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="service-block" style="display: flex; justify-content: center">
                    <img src="img/search_not_found.jpg" alt="emptylist">
                </div>
            </c:otherwise>
        </c:choose>
        <c:import url="footer.jsp"/>

    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
        const appear = document.querySelector('.appear');
        const cb = function (entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('inview');
                } else {
                    entry.target.classList.remove('inview');
                }
            });
        }
        const io = new IntersectionObserver(cb);
        io.observe(appear);
    </script>
</html>
