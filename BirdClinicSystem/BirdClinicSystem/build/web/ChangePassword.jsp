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
        <c:choose>
            <c:when test="${param.roleID == 1}">
                <c:set var="user" value="${sessionScope.admin}"></c:set>
            </c:when>
            <c:when test="${param.roleID == 2}">
                <c:set var="user" value="${sessionScope.staff}"></c:set>
            </c:when>
            <c:when test="${param.roleID == 3}">
                <c:set var="user" value="${sessionScope.doctor}"></c:set>
            </c:when>
            <c:when test="${param.roleID == 4}">
                <c:set var="user" value="${sessionScope.customer}"></c:set>
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${user==null}">
                <h1>Login required!</h1>
                <h1><a href="home">Back to home page</a></h1>
            </c:when>
            <c:otherwise>
                <div class="wrapper fadeInDown">
                    <div id="formContent" style=" height: 500px; width: 100%; padding: 20px;">
                        <form action="MainController">
                            <input type="hidden" name="roleID" value="${param.roleID}">
                            <input type="hidden" name="txtEmail" value="${user.email}">
                            <input type="hidden" name="ischangepassword" value="ischangepassword">
                            <h4 style="padding: 10px">Change Password</h4>
                            <c:if test="${user.password != null}">
                                <p style="text-align: left;margin: 0px; margin-left: 50px">Current password</p> 
                                <input type="password" name="txtCurrentPassword" value="${txtCurrentPassword}"><br>
                            </c:if>
                            <p style="text-align: left;margin: 0px; margin-left: 50px" >New password</p> 
                            <input type="password" name="txtNewPassword" value="${txtNewPassword}">
                            <p style="text-align: left;margin: 0px; margin-left: 50px">Confirm new password</p> 
                            <input type="password" name="txtConfirm" value="${txtConfirm}">
                            <h5 style="color: red; font-size: 10px; text-align: center; margin-top: 20px ">
                                ${requestScope.error}!
                            </h5>
                            <input type="hidden" value="Change Password" name="action">
                            <input type="submit" value="Reset">
                            
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "ChangePassword.jsp");
            }
        </script>
    </body>
</html>
