<%-- 
    Document   : header
    Created on : May 28, 2023, 8:58:20 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="sweetalert2.min.js"></script>
        <link href="css/PopUpMess.css" rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="pic col-md-4" >
                    <img src="img/pl 1.png" style="height: 75px; margin-right: 10px;" alt=""/>
                    <h1>Bird Clinic</h1>
                </div>
                <div class="menu col-md-4"style="display: flex;justify-content: space-evenly;align-items: center;" >
                    <a class="underlineHover" href="home">HOME</a>
                    <a class="underlineHover" href="MainController?action=viewPaginatedDoctor&page=1">ABOUT US</a>
                    <a class="underlineHover" href="MainController?action=searchService">SERVICE</a>
                    <a class="underlineHover" href="blog-list">BLOGS</a>   
                </div>

                <div class="left-header col-md-3" style="justify-content: flex-end;" >
                    <h3>
                        <a class="underlineHoverlogin" style="font-size: 25px; display: flex;justify-content: center;color:white">Welcome</a>
                        <a href="user-profile" class="underlineHoverlogin">${sessionScope.customer.fullname}</a>
                    </h3>
                    <div class="userlogo-header">
                        <img src="${sessionScope.customer.image == null ? 'img/user-icon.png' : sessionScope.customer.image}" alt="Error image" id="profile-pic" />
                    </div>
                </div>               
            </div>

        </div>

    </body>
</html>
