<%-- 
    Document   : forgotpassword.jsp
    Created on : May 30, 2023, 10:43:08 AM
    Author     : ADMIN
--%>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    </head>
    <body>
        <div class="wrapper fadeInDown">
            <div id="formContent" style="height: 350px; padding: 0px; padding-top: 20px;">
                <div style="display: flex;align-items: center;justify-content: flex-start;border-bottom: 2px solid grey;padding-bottom: 20px;">
                    <!--                    <a href="login" class="goback-button"><i class="fa-solid fa-circle-arrow-left fa-xl" style="color: #000000;"></i></a>-->
                    <h4 style="margin-left: 20px; ">Forgot your password?</h4>
                </div>           
                <form action="MainController" method="POST">
                    <div style="border-bottom: 2px solid grey; padding: 30px">
                        <span style="font-size: 24px;">Please enter your email address
                            to search for your account: </span>
                        <input type="text" name="email" value="${requestScope.email}" placeholder="Email...">
                        <div class="remind fadeIn second" >
                            ${requestScope.error}
                        </div> 
                    </div>
                    <div style="display: flex; align-items: center; justify-content: flex-end; margin-right: 20px">
                        <a class="return" style="color: white; text-decoration: none;" href="login">Back</a>
                        <input type="hidden" name="action" value="ForgotPassword">
                        <input style="padding:15px 50px; " type="submit" value="Confirm">

                    </div>
                </form> 
            </div>
        </div>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "forgot-password");
            }
        </script>
    </body>
</html>
