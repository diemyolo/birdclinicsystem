<%@page import="DTO.Doctor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DoctorDAO"%>
<%@page import="DAO.CustomersDAO"%>
<%@page import="DAO.AppointmentDAO"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="style/scheduleAppoint.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.customer == null}">
                <c:set var="warning" value="You need to log in as Customer to access this function" scope="request"/>
                <jsp:forward page="Login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="headerUser.jsp"/>
            </c:otherwise>
        </c:choose>
        <%@include file="NotificationMess.jsp" %>
        <div class="containerr">
            <ul class="progressbar">
                <li class="actived">Scheduling</li>
                <li>Finish details</li>
                <li>Confirmation</li>
            </ul>
        </div>

        


        <div style="width: 1020px; margin: 50px auto 10px;">
            <h5 style="font-weight: bold;">1. Choose the most suitable time that accommodates your schedule.</h5>
            <p>(Please note that your booked appointment must be at least <span style="color: green; font-weight: bold;">3 hours</span> in advanced)</p>
        </div>

        <div class="scheduleForm">            
            <form action="MainController?action=finishSchedule" method="post" class="scheduleAppoint">
                <input id="services" type="hidden" name="services" value=""/>
                <div class="calendar">        
                    <%                        //get current or chosen calendar
                        Calendar current = Calendar.getInstance();

                        int currentDay = current.get(Calendar.DAY_OF_MONTH);
                        int currentMonth = current.get(Calendar.MONTH);
                        int currentYear = current.get(Calendar.YEAR);

                        //get real time calendar
                        Calendar realTime = Calendar.getInstance();

                        int realTimeDay = realTime.get(Calendar.DAY_OF_MONTH);
                        int realTimeMonth = realTime.get(Calendar.MONTH);
                        int realTimeYear = realTime.get(Calendar.YEAR);

                        if (request.getAttribute("day") != null) {
                            currentDay = Integer.parseInt(request.getParameter("day"));
                            currentMonth = Integer.parseInt(request.getParameter("month"));
                            currentYear = Integer.parseInt(request.getParameter("year"));

                        }
                        // set the displayed calendar
                        Calendar calendar = Calendar.getInstance();

                        calendar.set(currentYear, currentMonth, 1);
                        // get the number of days
                        int numDays = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                        // get the start day (1 - 7)
                        int startDay = calendar.get(Calendar.DAY_OF_WEEK);

                        // get the previous month calendar
                        int previousMonth = (currentMonth == 0) ? 11 : currentMonth - 1;
                        int prevYear = (previousMonth == 11) ? currentYear - 1 : currentYear;
                        Calendar prevCalendar = Calendar.getInstance();
                        prevCalendar.set(prevYear, previousMonth, 1);

                        // get the following month calendar
                        int followingMonth = (currentMonth == 11) ? 0 : currentMonth + 1;
                        int followingYear = (followingMonth == 0) ? currentYear + 1 : currentYear;
                        Calendar followingCalendar = Calendar.getInstance();
                        followingCalendar.set(followingYear, followingMonth, 1);

                        String[] slots = {"", "8:00 - 9:30", "9:45 - 11:15", "12:30 - 14:00", "14:15 - 15:45", "16:00 - 17:30", "17:45 - 19:15"};
                        String[] months = {"January", "February", "March", "April", "May",
                            "June", "July", "August", "September", "October", "November", "December"};
                        String[] weekDays = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
                        int displayedStartDay = 0;
                    %>
                    <div class="displayed-month">
                        <p><%=months[currentMonth]%> <%=currentYear%></p>
                        <div style="margin: 5px 15px 0 0; display: flex; gap: 20px; font-weight: bold;">
                            <c:set var="compareRealTime" value="<%=calendar.compareTo(realTime)%>"/>
                            <c:if test="${compareRealTime > 0 }">
                                <a href="MainController?action=switchCalendar&day=<%=numDays - 1%>&month=<%=previousMonth%>&year=<%=prevYear%>"><i class="fa-solid fa-chevron-left fa-lg" style="color: #000000;"></i></a>
                                </c:if>                            
                            <a href="MainController?action=switchCalendar&day=1&month=<%=followingMonth%>&year=<%=followingYear%>"><i class="fa-solid fa-chevron-right fa-lg" style="color: #000000;"></i></a>                            
                        </div>
                    </div>

                    <table>
                        <tr>
                            <th>Sun</th>
                            <th>Mon</th>
                            <th>Tue</th>
                            <th>Wed</th>
                            <th>Thu</th>
                            <th>Fri</th>
                            <th>Sat</th>
                        </tr>
                        <tr>
                            <%

                                for (int i = 1; i < startDay; i++) {
                                    int prevDay = prevCalendar.getActualMaximum(Calendar.DAY_OF_MONTH) - (startDay - i - 1);
                                    if ((previousMonth < realTimeMonth && prevYear == realTimeYear) || (prevYear < realTimeYear)) {
                            %>
                            <td class="unactive"><%= prevDay%></td>
                            <% } else {%>
                            <td class="previous-month"><a href="MainController?action=switchCalendar&day=<%=prevDay%>&month=<%=previousMonth%>&year=<%=prevYear%>"><%= prevDay%></a></td>
                                <% }
                                    } %>

                            <% for (int day = 1; day <= numDays; day++) {
                                    if (startDay == 1) { %>
                        </tr>                        
                        <tr>
                            <% } %>
                            <% if (calendar.get(Calendar.DAY_OF_MONTH) == currentDay) {
                                    if (calendar.get(Calendar.DAY_OF_WEEK) == 1) {
                                        currentDay += 1;%>
                            <td class="unactive"><%= calendar.get(Calendar.DAY_OF_MONTH)%></td>
                            <%} else {%>
                            <td class="selected"><%= calendar.get(Calendar.DAY_OF_MONTH)%></td>
                            <%}
                                displayedStartDay = calendar.get(Calendar.DAY_OF_WEEK);
                            } else if (startDay == 1 || (calendar.compareTo(realTime) < 0)) {%>
                            <td class="unactive"><%= calendar.get(Calendar.DAY_OF_MONTH)%></td>
                            <%} else {%>
                            <td class="dates"><a href="MainController?action=switchCalendar&day=<%=calendar.get(Calendar.DAY_OF_MONTH)%>&month=<%=currentMonth%>&year=<%=currentYear%>"><%= calendar.get(Calendar.DAY_OF_MONTH)%></a></td>
                                <% } %>

                            <%-- Move to the next day --%>
                            <%
                                calendar.add(Calendar.DAY_OF_MONTH, 1);
                                startDay = calendar.get(Calendar.DAY_OF_WEEK);
                            %>
                            <% } %>

                            <%-- Insert empty cells for the remaining days of the last week --%>
                            <% while (startDay > 1 && startDay <= 7) {
                                    int nextDay = followingCalendar.get(Calendar.DAY_OF_MONTH);%>
                            <td class="following-month"><a href="MainController?action=switchCalendar&day=<%=nextDay%>&month=<%=followingMonth%>&year=<%=followingYear%>"><%=nextDay%></a></td>
                                <% followingCalendar.add(Calendar.DAY_OF_MONTH, 1);
                                    startDay = followingCalendar.get(Calendar.DAY_OF_WEEK);
                                %>
                                <% }%>
                        </tr>
                    </table>
                </div>
                <input type="hidden" name="date" value="<%=currentDay%>"/>
                <input type="hidden" name="month" value="<%=currentMonth%>"/>
                <input type="hidden" name="year" value="<%=currentYear%>"/>
                <div class="vertical-divider"></div>

                <% Calendar thisSlot = Calendar.getInstance();
                    thisSlot.set(currentYear, currentMonth, currentDay);%>
                <div>
                    <p><%=weekDays[displayedStartDay]%>, <%=months[currentMonth]%> <%=currentDay%></p>
                    <div class="slot">
                        <%  ArrayList<Doctor> checkSlot1 = DoctorDAO.getAvailableDoctorIDList(1, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 5);
                            thisSlot.set(Calendar.MINUTE, 0);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot1 == null || checkSlot1.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot1" class="time-slot unactiveSlot">8:00 - 9:30</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(1, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot1" class="time-slot unactiveSlot">8:00 - 9:30</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot1" class="time-slot">8:00 - 9:30</div>
                        <% } %>

                        <%  ArrayList<Doctor> checkSlot2 = DoctorDAO.getAvailableDoctorIDList(2, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 6);
                            thisSlot.set(Calendar.MINUTE, 45);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot2 == null || checkSlot2.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot2" class="time-slot unactiveSlot">9:45 - 11:15</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(2, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot2" class="time-slot unactiveSlot">9:45 - 11:15</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot2" class="time-slot">9:45 - 11:15</div>
                        <% } %>

                        <%  ArrayList<Doctor> checkSlot3 = DoctorDAO.getAvailableDoctorIDList(3, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 9);
                            thisSlot.set(Calendar.MINUTE, 30);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot3 == null || checkSlot3.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot3" class="time-slot unactiveSlot">12:30 - 14:00</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(3, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot3" class="time-slot unactiveSlot">12:30 - 14:00</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot3" class="time-slot">12:30 - 14:00</div>
                        <% } %>

                        <%  ArrayList<Doctor> checkSlot4 = DoctorDAO.getAvailableDoctorIDList(4, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 11);
                            thisSlot.set(Calendar.MINUTE, 15);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot4 == null || checkSlot4.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot4" class="time-slot unactiveSlot">14:15 - 15:45</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(4, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot4" class="time-slot unactiveSlot">14:15 - 15:45</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot4" class="time-slot">14:15 - 15:45</div>
                        <% } %>

                        <%  ArrayList<Doctor> checkSlot5 = DoctorDAO.getAvailableDoctorIDList(5, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 13);
                            thisSlot.set(Calendar.MINUTE, 0);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot5 == null || checkSlot5.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot5" class="time-slot unactiveSlot">16:00 - 17:30</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(5, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot5" class="time-slot unactiveSlot">16:00 - 17:30</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot5" class="time-slot">16:00 - 17:30</div>
                        <% } %>

                        <%  ArrayList<Doctor> checkSlot6 = DoctorDAO.getAvailableDoctorIDList(6, currentDay, currentMonth, currentYear);
                            thisSlot.set(Calendar.HOUR_OF_DAY, 14);
                            thisSlot.set(Calendar.MINUTE, 45);
                            thisSlot.set(Calendar.SECOND, 0);
                            if (checkSlot6 == null || checkSlot6.isEmpty() || realTime.compareTo(thisSlot) > 0) {%>
                        <div id="slot6" class="time-slot unactiveSlot">17:45 - 19:15</div>
                        <% } else if (AppointmentDAO.checkSlotIfBooked(6, currentDay, currentMonth, currentYear, CustomersDAO.getCustomerID((String) session.getAttribute("UserID")))) { %>
                        <div style="position: relative;">
                            <div id="slot6" class="time-slot unactiveSlot">17:45 - 19:15</div>
                            <img src="img/pinned_app.png" style="position: absolute; height: 35px; top: -20px; right: -20px;"/>
                        </div>
                        <% } else { %>
                        <div id="slot6" class="time-slot">17:45 - 19:15</div>
                        <% }%>
                        <input type="hidden" name="slot" value="0" id="chosen-slot"/>
                    </div>
                </div>
                <input type="submit" value="Next" id="nextBtn" class="cannot-next"/>
            </form>
        </div>

<div class="serviceSelectBox">
            <h5 style="font-weight: bold;">2. Select your desired services!</h5>
            <p>(Please note that you can only registered for a maximum of <span style="color: green; font-weight: bold;">two</span> services)</p>
            <div class="select-btn">
                <span class="btn-text">Select Services</span>
                <span class="arrow-dwn">
                    <i class="fa-solid fa-chevron-down"></i>
                </span>
            </div>

            <ul class="list-items">
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr;">
                    <li class="item">
                        <span class="checkbox">
                            <i class="fa-solid fa-check check-icon"></i>
                        </span>
                        <span class="item-text">Vaccination</span>
                    </li>
                    <li class="item">
                        <span class="checkbox">
                            <i class="fa-solid fa-check check-icon"></i>
                        </span>
                        <span class="item-text">Diagnose Examination</span>
                    </li>
                    <li class="item">
                        <span class="checkbox">
                            <i class="fa-solid fa-check check-icon"></i>
                        </span>
                        <span class="item-text">Veterinary Surgery</span>
                    </li>
                    <li class="item">
                        <span class="checkbox">
                            <i class="fa-solid fa-check check-icon"></i>
                        </span>
                        <span class="item-text">Hair Trimming</span>
                    </li>
                    <li class="item">
                        <span class="checkbox">
                            <i class="fa-solid fa-check check-icon"></i>
                        </span>
                        <span class="item-text">Nutrient Consultation</span>
                    </li>
                </div>
            </ul>
        </div>
        <footer>
            <%--<c:import url="footer.jsp"/>--%>
        </footer>

        <script type="text/javascript">
            const buttons = document.querySelectorAll('.time-slot');
            let activeButton = null;

            function handleClick(event) {
                const clickedButton = event.target;

                if (activeButton === clickedButton) {
                    return; // Ignore if the same button is clicked again
                }

                // Remove name attribute and active class from the previously active button
                if (activeButton) {
                    activeButton.removeAttribute('name');
                    activeButton.removeAttribute('value');
                    activeButton.classList.remove('active');
                    activeButton.addEventListener('click', handleClick);
                }

                // Add name attribute to the clicked button
                clickedButton.setAttribute('name', 'slot');
                clickedButton.setAttribute('value', clickedButton.id);
                clickedButton.classList.add('active');

                // Remove event listener from the clicked button
                clickedButton.removeEventListener('click', handleClick);

                // Set the clicked button as the active button
                activeButton = clickedButton;
                updateNextButtonState();
            }

            buttons.forEach(button => {
                button.addEventListener('click', handleClick);
            });

            var slot = document.getElementById("chosen-slot");
            var slotElement = document.getElementById("chosen-slot");
            var slot1 = document.querySelector("#slot1");
            var slot2 = document.querySelector("#slot2");
            var slot3 = document.querySelector("#slot3");
            var slot4 = document.querySelector("#slot4");
            var slot5 = document.querySelector("#slot5");
            var slot6 = document.querySelector("#slot6");
            slot1.addEventListener("click", function () {
                slot.value = "1";

            });
            slot2.addEventListener("click", function () {
                slot.value = "2";
            });
            slot3.addEventListener("click", function () {
                slot.value = "3";
            });
            slot4.addEventListener("click", function () {
                slot.value = "4";
            });
            slot5.addEventListener("click", function () {
                slot.value = "5";
            });
            slot6.addEventListener("click", function () {
                slot.value = "6";
            });

            const selectBtn = document.querySelector(".select-btn"),
                    items = document.querySelectorAll(".item");

            selectBtn.addEventListener("click", () => {
                selectBtn.classList.toggle("open");
            });
            let checked = document.querySelectorAll(".checked");
            let serviceInput = document.getElementById("services");

            items.forEach(item => {
                item.addEventListener("click", () => {
                    checked = document.querySelectorAll(".checked");
                    if (!item.classList.contains("checked")) {
                        if (checked.length < 2) {
                            item.classList.add("checked");
                        }
                    } else {
                        item.classList.remove("checked");
                    }

                    let btnText = document.querySelector(".btn-text");
                    checked = document.querySelectorAll(".checked");
                    serviceInput = document.getElementById("services");

                    if (checked.length > 0) {
                        btnText.innerHTML = "";
                        checked.forEach((checkedItem, index) => {
                            if (index > 0) {
                                btnText.innerHTML += ", ";
                            }
                            btnText.innerHTML += checkedItem.textContent;
                        });
                        serviceInput.value = Array.from(checked)
                                .map((checkedItem) => checkedItem.textContent)
                                .join(", ");
                    } else {
                        btnText.innerText = "Select Services";
                        serviceInput.value = "";
                    }

                    if (checked.length === 2) {
                        items.forEach(otherItem => {
                            if (!otherItem.classList.contains("checked")) {
                                otherItem.classList.add("disabled");
                            }
                        });
                    } else {
                        items.forEach(otherItem => {
                            if (!otherItem.classList.contains("checked")) {
                                otherItem.classList.remove("disabled");
                            }
                        });
                    }
                    updateNextButtonState();
                });
            })

            function updateNextButtonState() {
                const nextBtn = document.querySelector("#nextBtn");
                const timeSlots = document.querySelectorAll(".time-slot");
                const items = document.querySelectorAll(".item");
                const activeTimeSlot = document.querySelector(".time-slot.active");
                const checkedItems = document.querySelectorAll(".item.checked");

                if (!activeTimeSlot || checkedItems.length === 0) {
                    nextBtn.classList.add("cannot-next");
                } else {
                    nextBtn.classList.remove("cannot-next");
                }
            }

        </script>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "ScheduleAppointment.jsp");
            }
        </script>
    </body>
</html>
