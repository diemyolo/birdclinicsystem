<%@page import="DTO.Medicine"%>
<%@page import="DAO.MedicineDAO"%>
<%@page import="DAO.DoctorDAO"%>
<%@page import="DAO.MedRecordDAO"%>
<%@page import="DTO.Prescription"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.PrescriptionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="style/prescription.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
        <c:set var="prescription" value="${PrescriptionDAO.checkPresExist(requestScope.appID)}"/>
        <c:set var="medRecord" value="${MedRecordDAO.getMedRecordWithAppID(requestScope.appID)}"/>
        <a href="Doctor_AppointmentList.jsp" class="back_btn">Back</a>
        <c:choose>
            <c:when test="${empty medRecord}">
                <c:set var="warning" value="A Medical Record have to be created first!" scope="request"/>
                <jsp:forward page="MedicalRecordServlet?appID=${requestScope.appID}"/>
            </c:when>
            <c:when test="${empty prescription}">
                <div class="empty_pres">
                    <div style="text-align: center;">
                        <h1>There has been no prescription created yet!</h1>
                        <a href="AddNewPresServlet?appID=${requestScope.appID}&docID=${requestScope.docID}">ADD <i class="fa-solid fa-plus"></i></a>
                    </div>
                </div>
            </c:when>        
            <c:otherwise>
                <div class="form_wrapper">
                    <h1 class="form_title">Prescription</h1>
                    <!--<img src="img/capsule.png" style="position: absolute; height: 50px; height: 42px; top: 75px; left: 340px;"/>-->
                    <table class="form_info_table">
                        <tr>
                            <td class="strong">Date</td>
                            <td>: ${prescription.getDate()}</td>
                        </tr>
                        <tr>
                            <td class="strong">ID</td>
                            <td>: ${prescription.getPresID()}</td>
                        </tr>
                        <tr>
                            <td class="strong">Doctor</td>
                            <c:set var="docID" value="${prescription.getDocID()}"/>
                            <c:set var="docName" value="${DoctorDAO.getDoctorNameByID(docID)}"/>
                            <td>: ${docName}</td>
                        </tr>
                    </table>

                    <!--                <h5>Prescription Instruction</h5>
                                    <div>
                                        <textarea id="usage" rows="6" placeholder="Usage..."></textarea>
                                    </div>-->

                    <div class="divider"></div>

                    <table class="med_row">
                        <tr>
                            <th class="med_name">Medicine</th>
                            <th class="med_info">Unit price</th>
                            <th class="med_info">Quantity</th>
                            <th class="med_info">Total price</th>
                            <th class="med_action"></th>
                        </tr>
                        <c:set var="pres" value="${prescription.getPresID()}"/>
                        <!--show med list-->
                        <c:set var="total" value="0"/>
                        <div id="pres_detail_record">
                            <c:forEach var="med" items="${PrescriptionDAO.getPDByPresID(pres)}">
                                <tr class="med_row_record">
                                    <td class="med_name med_name1">${med.getMedName()} <br> <span>${med.getUsage()}</span></td>
                                    <td class="med_info">$ ${med.getMedPrice()}</td>
                                    <td class="med_info">${med.getQuantity()}</td>
                                    <td class="med_info">$ ${String.format("%.2f", med.getMedPrice() * med.getQuantity())}</td>
                                    <td class="med_action">
                                        <c:if test="${requestScope.app.getStatus() eq 1}">
                                            <a href="DeletePresDetailServlet?PD=${med.getPD()}&appID=${requestScope.appID}&docID=${requestScope.docID}&quantity=${med.getQuantity()}&medid=${med.getMedID()}"><i class="fa-solid fa-trash-can" style="color: black;"></i></a>
                                            </c:if>                                
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + (med.getMedPrice() * med.getQuantity())}"/>
                            </c:forEach>
                        </div>


                        <!--add new med-->
                        <c:if test="${not empty requestScope.addedMedID}">
                            <c:set var="addedMed" value="${MedicineDAO.getMedicineByID(requestScope.addedMedID)}"/>
                            <form method="post" action="AddPresDetailServlet?medID=${requestScope.addedMedID}&presID=${prescription.getPresID()}&appID=${requestScope.appID}&docID=${requestScope.docID}">
                                <tr class="med_row_record add_new_record">
                                    <td class="med_name med_name1">${addedMed.getMedName()}<br><span><input type="text" name="usage" style="margin-top: 5px;"/></span></td>
                                    <td class="med_info med_price">${addedMed.getMedPrice()}</td>
                                    <td class="med_info"><input type="number" name="MedQuantity" value="1" class="input_quantity" min="0" max="${addedMed.getRemainingQuantity()}"/></td>
                                    <td class="med_info total_price"></td>
                                    <td class="med_action">
                                        <button type="submit" class="hover_opacity" style="border: none; box-shadow: none;">
                                            <i class="fa-solid fa-square-check fa-xl" style="color: #3ed6a8;" ></i>
                                        </button>
                                        <a href="PrescriptionServlet?appID=${requestScope.appID}&docID=${requestScope.docID}" class="hover_opacity"><i class="fa-solid fa-square-xmark fa-xl" style="color: #8c1414;"></i></a>
                                    </td>
                                </tr>
                            </form>
                        </c:if>

                    </table>
                    <c:if test="${not PrescriptionDAO.checkPDExist(prescription.getPresID()) and empty requestScope.addedMedID}">
                        <div class="empty_presDetail">
                            <img src="img/emptyPresDetail.png"/>
                            <h3>Prescription is empty!</h3>
                        </div>
                    </c:if>                        
                    <c:if test="${requestScope.app.getStatus() eq 1}">
                        <a href="#choose_med" class="add_med">ADD <span><i class="fa-solid fa-plus"></i></span></a>
                            </c:if>
                    <div id="choose_med">
                        <div class="choose_med_wrapper">
                            <div >
                                <a href="#" class="close_btn">
                                    <i class="fa-solid fa-square-xmark fa-2xl" style="color: rgba(0, 0, 0, 0.8);" class="close"></i>
                                </a>
                            </div>

                            <h1>Choose Medicine</h1>
                            <form method="get" action="PrescriptionServlet?#choose_med" class="searchMed">
                                <input type="hidden" name="appID" value="${requestScope.appID}"/>
                                <input type="hidden" name="docID" value="${requestScope.docID}"/>
                                <input type="text" name="keyword" placeholder="Search by name..."/>
                                <!--<i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i>-->    
                            </form>
                            <%
                                String keyword = request.getParameter("keyword");
                                String appID = (String) request.getAttribute("appID");
                                Prescription pres = PrescriptionDAO.checkPresExist(appID);

                                String presID = pres.getPresID();
                                request.setAttribute("presID", presID);

                                ArrayList<Medicine> list;
                                if (keyword == null) {
                                    list = MedicineDAO.searchMedByKeyWordToAdd("", pres.getPresID());
                                } else {
                                    list = MedicineDAO.searchMedByKeyWordToAdd(keyword, pres.getPresID());
                                }
                            %>
                            <form method="post" action="" class="form_choose_med">
                                <table class="form_choose_med_table">
                                    <tr>
                                        <th>Name</th>
                                        <th>Prices</th>
                                        <th>Description</th>
                                        <th>Remaining</th>
                                        <th></th>
                                    </tr>
                                    <c:forEach var="med" items="<%=list%>">
                                        <tr>
                                            <td>${med.getMedName()}</td>
                                            <td>$ ${med.getMedPrice()}</td>
                                            <td>${med.getMedDescription()}</td>
                                            <td>${med.getRemainingQuantity()}</td>
                                            <td><a href="PrescriptionServlet?appID=${requestScope.appID}&docID=${requestScope.docID}&addedMedID=${med.getMedID()}" class="choose_one_med">Choose</a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </form>
                        </div>

                    </div>
                </div>

                <div class="prescription_total">
                    <div class="total_box">
                        <table>
                            <tr>
                                <td style="padding-right: 5px;">Subtotal  :   $</td>
                                <c:choose>
                                    <c:when test="${total eq 0}">
                                        <td></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td> ${String.format("%.2f",total)}</td>
                                    </c:otherwise>
                                </c:choose>                                        
                            </tr>
                            <tr>
                                <td style="padding-right: 5px;">Tax (10%)  :   $</td>
                                <c:choose>
                                    <c:when test="${total eq 0}">
                                        <td></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td> ${String.format("%.2f",total*0.1)}</td>
                                    </c:otherwise>
                                </c:choose>  

                            </tr>
                            <tr>
                                <td style="padding-right: 5px;">Total  :   $</td>
                                <c:choose>
                                    <c:when test="${total eq 0}">
                                        <td></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td> ${String.format("%.2f",total*1.1)}</td>
                                    </c:otherwise>
                                </c:choose>  

                            </tr>
                        </table>

                    </div>
                    <c:if test="${requestScope.app.getStatus() eq 1}">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="AppID" value="${requestScope.appID}">
                            <input type="hidden" name="PresID" value="${presID}">
                            <input type="hidden" name="TotalPresMoney" value="${total}">
                            <input type="hidden" name="DocID" value="${docID}">
                            <input type="hidden" name="action" value="AddInvoice">
                            <input type="submit" value="Save To Invoice" class="saveToInvoiceBtn">
                        </form>
                    </c:if>

                </div>
            </c:otherwise>
        </c:choose>
    </body>

    <script>
        const userInput = document.getElementById("usage");

        function handleEnterKey(event, userInput) {
            if (event.key === "Enter") {
                event.preventDefault();
                if (!userInput.value.startsWith("-")) {
                    userInput.value = "- " + userInput.value.trim();
                } else {
                    userInput.value += "\n- ";
                }
            }
        }

        function handleInitialInput(userInput) {
            if (!userInput.value.startsWith("-")) {
                userInput.value = "- " + userInput.value.trim();
            }
        }

//        userInput.addEventListener("keydown", function (event) {
//            handleEnterKey(event, userInput);
//        });
//        userInput.addEventListener("input", function () {
//            handleInitialInput(userInput);
//        });

        //calculate the total price
        const medPriceElement = document.querySelector('.med_info.med_price');
        const quantityElement = document.querySelector('.input_quantity');
        const totalPriceElement = document.querySelector('.med_info.total_price');


        updateTotalPrice();
        // Add an event listener to the quantity input field
        quantityElement.addEventListener('input', updateTotalPrice);

        // Function to update the total price
        function updateTotalPrice() {
            const medPrice = parseFloat(medPriceElement.innerText);
            const quantity = parseFloat(quantityElement.value);

            // Calculate the total price
            const totalPrice = medPrice * quantity;

            // Update the total price element
            totalPriceElement.innerText = totalPrice.toFixed(2); // Assuming you want to display the total price with two decimal places
        }
    </script>
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, "Prescription.jsp");
        }
    </script>
</html>
