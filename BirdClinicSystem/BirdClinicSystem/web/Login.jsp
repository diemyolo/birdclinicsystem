<%-- 
    Document   : templet
    Created on : Apr 24, 2023, 8:21:07 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="css/Login.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <style>
            .more{
                margin-top: 20px;
                color: red;
            }
        </style>
    </head>
    <body>
        <!-- Display Warning -->
        <c:if test="${requestScope.warning != null}">
            <c:set var="notify" value="${requestScope.warning}" scope="request" />
            <c:set var="condition" value="failed" scope="request" />
            <%@include file="NotificationMess.jsp" %>
        </c:if>
        <c:choose>
            <c:when test="${empty requestScope.warning}">
                <div class="wrapper fadeInDown">
                </c:when>
                <c:otherwise>
                    <div class="wrapper">
                    </c:otherwise>
                </c:choose>
                <div id="formContent">

                    <div class="fadeIn first cen1" style="margin-top: 20px">
                        <!--                    <div class="goback-button"> <a href="home">
                                                    Back
                                                </a>
                                                 
                                            </div>-->
                        <h4 style="margin: 10px 165px;">SIGN IN</h4>
                        <br>
                    </div>
                    <!-- Login Form -->
                    <c:set var="cookie" value="${pageContext.request.cookies}"/>
                    <div class="form-con">
                        <form  action="LoginServlet" method="POST">
                            <p class="fadeIn second">Email or phone number:</p>   
                            <input type="text" id="login" class="fadeIn second cen" name="txtUsername" value="${requestScope.txtUsername == null ? cookie.Username.value : requestScope.txtUsername}">
                            <p class="fadeIn second">Password</p>
                            <input type="password" id="password" class="fadeIn second cen" name="txtPassword" value="${requestScope.txtPassword == null ? cookie.Password.value : requestScope.txtPassword}"> 
                            <div style="display: flex; margin-top: 5px;">
                                <div class="remind fadeIn second">
                                    <input type="checkbox" id="vehicle1" name="remember" value="1" ${cookie.Remember != null ? 'checked' : ''}>
                                    <label for="" style="color: black;"> Remember Me</label>
                                    <br>
                                    ${WARNING}              
                                </div>
                                <div style="font-size: 15px;"><a href="forgot-password">Forgot Password?</a></div>
                            </div>
                            <input type="hidden" name="action" value="Login">
                            <input type="submit" class="fadeIn second button" value="Log In">                      
                        </form>
                    </div>
                                <div class="goback-button">
                        <span style="margin-right: 5px">Go back to </span> <a href="home">home page</a> <span style="margin-left: 5px"></span> 
                    </div>
                    <!-- Remind Passowrd -->
                </div>

                <div class="acc fadeIn third">
                    <i class="fa-solid fa-user-plus fa-lg" style="color: #000000;"></i>
                    <a class="underlineHover cen" style="text-decoration: none;" href="sign-up"> Create An Account</a>
                </div>

                <div class="acc fadeIn third">
                    <i class="fa-brands fa-lg fa-google"></i>
                    <a class="underlineHover cen" style="text-decoration: none;" href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:3030/BirdClinicSystem/LoginGoogleServlet&response_type=code&client_id=214881563869-0r4uvnl6e104d3k4fre3imc29j0l459h.apps.googleusercontent.com">Login with google</a>

                </div>
            </div>
                                
            <script>
                if (window.history.replaceState) {
                    window.history.replaceState(null, null, "login");
                }
            </script>
    </body>
</html>
