<%-- 
    Document   : ResetPassword
    Created on : May 30, 2023, 9:40:30 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet"href="css/Login.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>
    <body>
        <div class="wrapper fadeInDown">

            <c:choose>
                <c:when test="${param.code == null && sessionScope.code!=null}">
                    <div id="formContent" style="padding: 20px;align-items: center;height: 200px;">
                        <img src="img/pl 1.png" style="height: 75px; margin-top:-70px" alt=""/>
                        <h4>An email has been sent to your account, please click the link in your mail to verify</h4>
                        <a class="underlineHoverlogin" href="Login.jsp">Click Here to go Back Login</a>
                    </div>
                </c:when>
                <c:when test="${!param.code.equals(sessionScope.code)}">
                    <div id="formContent" style="padding: 20px;align-items: center; display: flex;height: 100px;">
                        <h4>Verification code time out, click <a href="forgot-password">here</a> to receive an another email!</h4>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="formContent" style="height: 400px; width: 100%">
                        <h1>Welcome ${param.email == null ? requestScope.email : param.email}</h1>
                        <form action="MainController" method="POST">
                            <input type="hidden" name="code" value="${param.code}">
                            <input type="hidden" name="txtEmail" value="${param.email}">
                            New password <input type="password" name="txtNewPassword" value="${txtNewPassword}"><br>
                            Confirm new password <input type="password" name="txtConfirm" value="${txtConfirm}">
                            <input type="hidden" value="ResetPassword" name="action">
                            <input type="submit" value="Reset">
                            <h5 style="color: red; font-size: 10px; text-align: center; margin-top: 20px ">${requestScope.error}</h5>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>  
        </div>
    </body>
</html>
