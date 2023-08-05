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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/header.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <img src="img/pl 1.png" alt=""/>
                <h1 style="margin-top: 30px; margin-left: 20px; font-size: xx-large;">Bird Clinic</h1>
            </div>
            <a class="underlineHover" style="flex-grow: 1;" href="HomePage.jsp">Home</a>
            <a class="underlineHover" style="flex-grow: 1;" href="DoctorPage.jsp">About Us</a>
            <a class="underlineHover" style="flex-grow: 1;" href="ServiceList.jsp">Service</a>
            <a class="underlineHover" style="flex-grow: 1;" href="BlogList.jsp">Blogs</a> 
            <div class="login underlineHoverlogin " style="flex-grow: 4">
                <h2>
                    <a class="underlineHoverlogin">Welcome</a>
                    <a class="underlineHoverlogin">${sessionScope.name}</a>
                </h2>
                <div class="centerlogout">
                  <form method="POST">
                    <a href="MainController?action=logout">
                        <svg style="margin-right: 30px;" xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">               
                        <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                        <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                        </svg>
                    </a>                                            
                </form>  
                </div>
                
            </div>
        </div>

    </body>
</html>
