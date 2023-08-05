<%-- 
    Document   : changeprofiledemo
    Created on : May 28, 2023, 5:01:45 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change profile</title>
    </head>
    <body>
        <form action="MainController" method ="post">
            <table>
            <h1>Change profile </h1>
            <tr>
                <td>Name</td>
                <td><input type="text" name="txtFullName"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
            <tr>
                <td>Gender</td>
                <td><input type="text" name="txtGender"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="txtEmail"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="text" name="txtPassword"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
            <tr>
                <td>Phone</td>
                <td><input type="text" name="txtPhone"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
            <tr>
                <td>Address</td>
                <td><input type="text" name="txtAddress"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>
<!--            <tr>
                <td>Birth date</td>
                <td><input type="text" name="txtBirthDate"></td>
                <td colspan="2"><input type="submit" value="Change" name="action"></td>   
            </tr>-->
            </table>
        </form>
    </body>
</html>
