<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>

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
        <link href="css/style.css" rel="stylesheet">
        <link href="css/serviceDetail.css" rel="stylesheet">
        <link rel="stylesheet" href="css/swiper-bundle.min.css">
    </head>
    <body>
        <!-- Check login -->
        <c:choose>
            <c:when test="${sessionScope.customer != null}">
                <c:import url="headerUser.jsp"/>
            </c:when>
            <c:when test="${sessionScope.staff != null}">
                <c:import url="StaffHeader.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="header.jsp"/>
            </c:otherwise>
        </c:choose>

        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel1 pictureCarusel "> 
                    <img style="width: 100%" src="img/Banner (4).png" alt=""/>
                </div>
            </div>
        </div>
        <div class="container-content">
            <div class="content-detail">
                <h2>Introduction</h2>
                <p>Emergency 24/7 service offers immediate and around-the-clock avian veterinary care for birds in critical situations.
                    With rapid response and advanced diagnostic capabilities, our team of experienced avian veterinarians is equipped to assess 
                    and provide prompt and appropriate emergency care. Whether it's trauma, sudden illness, or other urgent conditions, our comprehensive emergency treatment 
                    and care aim to stabilize and support birds during critical moments. Trust our Bird Emergency 24/7 service to provide expert care 
                    when your feathered companion needs it the most, ensuring their health and well-being.
                </p>
                <h2>Immediate Avian Veterinary Care</h2>
                <p> Highlight the significance of immediate avian veterinary care during emergencies. 
                    Explain that bird emergencies can include conditions such as trauma, respiratory distress, egg-binding, toxic ingestion, or sudden illness. 
                    Mention that our bird emergency service operates 24/7, ensuring that expert avian veterinarians are available to assess 
                    and provide immediate care for birds in critical situations. Emphasize the importance of acting swiftly to increase the chances of successful treatment and recovery.
                </p>
                <h2>Rapid Response and Diagnostic Capabilities</h2>
                <p>Describe the rapid response and diagnostic capabilities of the bird emergency service.
                    Explain that our dedicated team of avian veterinarians is equipped with advanced medical equipment and diagnostic tools to quickly assess 
                    and diagnose bird emergencies. Mention the availability of on-site laboratory facilities, radiography, endoscopy, 
                    and other necessary equipment to aid in prompt and accurate diagnosis. Highlight the ability to stabilize birds, administer emergency treatments,
                    and perform life-saving procedures when necessary.
                </p>               
                <h2>Comprehensive Emergency Treatment</h2>
                <p>Highlight the comprehensive emergency treatment and care provided by the bird emergency service. 
                    Explain that our avian veterinarians are experienced in handling a wide range of bird emergencies, including wound management, fracture repair, fluid therapy, 
                    respiratory support, and critical care. Mention the focus on pain management, stabilization, 
                    and monitoring to ensure the best possible outcome for the bird's health and well-being. Highlight the seamless coordination between the emergency team 
                    and other avian specialists for ongoing or follow-up care if needed.</p>
                <div class="center-div"></div>
            </div>
            <div class="sub-info">
                <h2 style="text-align: center; margin:20px auto; color: green;">Other Services</h2>
                <div class="other-service">
                    <a class="underlineHover" href="vaccination">Vaccination</a><br>
                    <a class="underlineHover" href="diagnostic-examination" >Diagnostic Examination</a><br>
                    <a class="underlineHover" href="veterinary-surgery" >Veterinary Surgery</a><br>
                    <a class="underlineHover" href="hair-trimming">Hair Trimming</a><br>
                    <a class="underlineHover" href="nutrient-consultation">Nutrients Consultation</a><br>
                </div>

            </div>
        </div>
        <br>
        <div class="contain-slider">
            <h1 style="text-align: center; margin-bottom: -30px; padding: 30px; color: white; font-size: 70px;; font-weight: bold;  ">Review</h1>

            <div class="body-slider">           
                <div class="slide-container swiper">
                    <div class="slide-content">
                        <div class="card-wrapper swiper-wrapper">
                            <div class="card swiper-slide">
                                <div class="image-content">
                                    <span class="overlay"></span>

                                    <div class="card-image">
                                        <img src="img/CaoBao.png" alt="" class="card-img">                               
                                    </div>
                                </div>

                                <div class="card-content">
                                    <h2 class="name">David Dell</h2>
                                    <p class="description">We really like Dr. Smith. He takes his time with Kelly and answers all of our questions. We never feel rushed during our appointment and he does not recommend unneeded tests. He answers our phone calls very quickly. We are in good hands with Dr. Smith.</p>
                                </div>
                            </div>
                            <div class="card swiper-slide">
                                <div class="image-content">
                                    <span class="overlay"></span>

                                    <div class="card-image">
                                        <img src="img/Kien.png" alt="" class="card-img">                               
                                    </div>
                                </div>

                                <div class="card-content">
                                    <h2 class="name">David Dell</h2>
                                    <p class="description">We really like Dr. Smith. He takes his time with Kelly and answers all of our questions. We never feel rushed during our appointment and he does not recommend unneeded tests. He answers our phone calls very quickly. We are in good hands with Dr. Smith.</p>
                                </div>
                            </div>
                            <div class="card swiper-slide">
                                <div class="image-content">
                                    <span class="overlay"></span>

                                    <div class="card-image">
                                        <img src="img/bao.png" alt="" class="card-img">                               
                                    </div>
                                </div>

                                <div class="card-content">
                                    <h2 class="name">David Dell</h2>
                                    <p class="description">We really like Dr. Smith. He takes his time with Kelly and answers all of our questions. We never feel rushed during our appointment and he does not recommend unneeded tests. He answers our phone calls very quickly. We are in good hands with Dr. Smith.</p>
                                </div>
                            </div>
                            <div class="card swiper-slide">
                                <div class="image-content">
                                    <span class="overlay"></span>

                                    <div class="card-image">
                                        <img src="img/diem.png"  alt="" class="card-img">

                                    </div>
                                </div>

                                <div class="card-content">
                                    <h2 class="name">David Dell</h2>
                                    <p class="description">We really like Dr. Smith. He takes his time with Kelly and answers all of our questions. We never feel rushed during our appointment and he does not recommend unneeded tests. He answers our phone calls very quickly. We are in good hands with Dr. Smith.</p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div style="display: none;">
                    <div class="swiper-button-next swiper-navBtn"></div>
                    <div class="swiper-button-prev swiper-navBtn"></div>
                    <div class="swiper-pagination"></div>
                </div>

            </div>
        </div>
        <footer>
            <c:import url="footer.jsp"/>
        </footer>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "Emergency.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/swiper-bundle.min.js"></script>
    <script src="js/script.js"></script>
</html>
