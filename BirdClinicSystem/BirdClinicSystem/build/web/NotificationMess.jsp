<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <link href="assets/css/font-awesome.min.css" rel="stylesheet">
        <script src="assets/js/script.js"></script>

    </head>
    <body>
        <%
            String notify = (String) request.getAttribute("notify");
            String condition = (String) request.getAttribute("condition");
            if (notify != null && condition.equals("sucess")) {
        %>
        <div id="myAlert" class="alert alert-warning alert-dismissible fade show fadeInDown" role="alert">
            <strong><%= notify%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            request.setAttribute("notify", null);
            request.setAttribute("condition", null);
        } else if(notify != null && condition.equals("failed")) {
        %>
        <div id="myAlert-error" class="alert alert-warning alert-dismissible fade show fadeInDown" role="alert">
            <strong><%= notify%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            request.setAttribute("notify", null);
            request.setAttribute("condition", null);
            }
        %>
    </body>
</html>