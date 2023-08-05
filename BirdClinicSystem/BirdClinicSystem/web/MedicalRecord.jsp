<%@page import="DTO.Appointments"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="style/medical_record.css"/>
    </head>
    <body style="background-color: transparent;">
        <header>
            <!-- Check if logined -->
            <c:choose>
                <c:when test="${sessionScope.doctor == null}">
                    <c:set var="warning" value="You need to log in as Doctor to access this function" scope="request"/>
                    <jsp:forward page="Login.jsp"/>
                </c:when>
                <c:otherwise>
                    <c:import url="DoctorHeader.jsp"/>
                </c:otherwise>
            </c:choose>
        </header>

        <c:if test="${requestScope.warning != null}">
            <c:set var="notify" value="${requestScope.warning}" scope="request" />
            <c:set var="condition" value="failed" scope="request" />                   
        </c:if>
        <%@include file="NotificationMess.jsp" %> 
        <% String[] slots = {"", "8:00 - 9:30", "9:45 - 11:15", "12:30 - 14:00", "14:15 - 15:45", "16:00 - 17:30", "17:45 - 19:15"};
            Appointments appoint = (Appointments) request.getAttribute("app");
            int slot = appoint.getSlotID();%>
        <a href="Doctor_AppointmentList.jsp" class="back_btn">Back</a>
        <form class="form_wrapper" method="post" action="UpdateMedicalRecordServlet">
            <h1 class="form_title">Medical Record</h1>
            <div class="form_detail_wrapper">
                <table class="form_detail_table">
                    <tr>
                        <td style="width: 15%;"><strong>Owner</strong></td>
                        <td colspan="2">${requestScope.cus.getFullname()}</td>
                        <td style="width: 20%;"><strong>Phone number</strong></td>
                        <td colspan="2">${requestScope.cus.getPhone()}</td>
                    </tr>
                    <tr>
                        <td><strong>Doctor in charge</strong></td>
                        <td colspan="5">${requestScope.docName}</td>
                    </tr>
                    <tr>
                        <td><strong>Date</strong></td>
                        <td colspan="2">${requestScope.app.getAppointDate()}</td>
                        <td><strong>Time</strong></td>
                        <td colspan="2"><%=slots[slot]%></td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: center; font-size: 25px; border-left: none; border-right: none; padding: 30px 0;"><strong>TEST & RESULT</strong></td>
                    </tr>
                    <tr>
                        <td><strong>Bird name</strong></td>
                        <td colspan="2">${requestScope.bird.getBird_name()}</td>
                        <td><strong>Species</strong></td>
                        <td>${requestScope.bird.getBird_type()}</td>
                    </tr>
                    <tr>
                        <td><strong>Age</strong></td>
                        <td colspan="2">${requestScope.bird.getAge_cate()}</td>
                        <td><strong>Weight</strong></td>
                        <td colspan="2">${requestScope.bird.getWeight()} kg</td>
                    </tr>
                    <c:set var="readOnly" value="${requestScope.app.getStatus() eq 1}"/>
                    <tr>
                        <td><strong>Symptoms</strong></td>
                        <td colspan="5">
                            <textarea id="symptoms" name="symptoms" rows="5" placeholder="Symptoms..." ${readOnly ? '' : 'readonly'}>${requestScope.MedRecord.getSymptoms()}</textarea>
                        </td>              
                    </tr>
                    <tr>
                        <td><strong>Diagnosis</strong></td>
                        <td colspan="5">
                            <textarea id="diagnosis" name="diagnosis" rows="6" placeholder="Diagnosis..." ${readOnly ? '' : 'readonly'}>${requestScope.MedRecord.getDiagnosis()}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Treatment plan</strong></td>
                        <td colspan="5">
                            <textarea id="treatment" name="treatment" rows="6" placeholder="Treatment..." ${readOnly ? '' : 'readonly'}>${requestScope.MedRecord.getTreatment()}</textarea>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="birdID" value="${requestScope.bird.getBirdID()}"/>
                <input type="hidden" name="appID" value="${requestScope.app.getAppID()}"/>
                <c:if test="${requestScope.app.getStatus() eq 1}">
                    <div class="btnwrap">
                        <c:choose>
                            <c:when test="${empty requestScope.MedRecord}">
                                <input type="submit" class="submitBtn" value="Save"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="submitBtn" value="Update" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

            </div>


        </form>

        <script>
            const userInput1 = document.getElementById("diagnosis");
            const userInput2 = document.getElementById("treatment");
            const userInput3 = document.getElementById("symptoms");

            function handleEnterKey(event, userInput) {
                if (event.key === "Enter") {
                    event.preventDefault();
                    if (!userInput.value.startsWith("+")) {
                        userInput.value = "+ " + userInput.value.trim();
                    } else {
                        userInput.value += "\n+ ";
                    }
                }
            }

            function handleInitialInput(userInput) {
                if (!userInput.value.startsWith("+")) {
                    userInput.value = "+ " + userInput.value.trim();
                }
            }

            userInput1.addEventListener("keydown", function (event) {
                handleEnterKey(event, userInput1);
            });

            userInput2.addEventListener("keydown", function (event) {
                handleEnterKey(event, userInput2);
            });

            userInput3.addEventListener("keydown", function (event) {
                handleEnterKey(event, userInput3);
            });

            userInput1.addEventListener("input", function () {
                handleInitialInput(userInput1);
            });

            userInput2.addEventListener("input", function () {
                handleInitialInput(userInput2);
            });

            userInput3.addEventListener("input", function () {
                handleInitialInput(userInput3);
            });

        </script>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "MedicalRecord.jsp");
            }
        </script>
    </body>
</html>
