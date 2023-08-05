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
                    <img style="width: 100%" src="img/Banner.jpg" alt=""/>
                </div>
            </div>
        </div>
        <div class="container-content">
            <div class="content-detail">
                <h2>Introduction</h2>
                <p>At our bird clinic, we understand that every bird is unique, and their vaccination needs may vary. 
                    That's why we offer customized vaccination plans tailored to the specific requirements of your bird. 
                    Our avian veterinarians take into account factors such as species, age, lifestyle, and potential exposure risks when developing a vaccination schedule. 
                    By personalizing the vaccination plan, we ensure that your bird receives the appropriate vaccines at the right time, 
                    providing them with optimal protection against common avian diseases.                  
                </p>
                <h2>Careful Vaccine Selection</h2>
                <p>Our team of avian veterinarians has in-depth knowledge of the various vaccines available for birds. 
                    We carefully select the appropriate vaccines based on the specific needs of your bird. Factors such as their species, age, 
                    and potential exposure risks are taken into consideration to ensure optimal protection. We stay updated with the latest research 
                    and recommendations to offer the most effective and reliable vaccines for avian diseases.
                </p>
                <h2>Professional Administration </h2>
                <p>When it comes to administering vaccines, our avian veterinarians prioritize the safety and well-being of your bird. 
                    We have expertise in handling birds of different species and sizes, ensuring a calm and stress-free environment during the vaccination process. 
                </p>               
                <p>Our team employs gentle restraint techniques and uses sterile equipment to administer the vaccines accurately and minimize any discomfort for your bird. 
                    We also pay close attention to proper dosage and administration routes, such as injections, oral delivery, or nasal drops, depending on the specific vaccine requirements.</p>
                <h2>Post-Vaccination Monitoring </h2>
                <p>After vaccination, we understand the importance of monitoring your bird's response. 
                    Our avian clinic provides dedicated post-vaccination care instructions to ensure the best recovery for your bird. 
                    We closely observe for any adverse reactions or signs of distress, providing prompt medical attention if necessary. 
                    Our team is available to address any concerns or questions you may have during the crucial post-vaccination period. 
                    Additionally, we offer guidance on the timing of follow-up vaccinations or booster shots to maintain your bird's immunity against targeted diseases</p>
                    <c:choose>
                        <c:when test="${sessionScope.customer != null}">
                        <div class="center-div"><input type="submit" class="button" value="Book Now!" ></div>
                        </c:when>
                        <c:when test="${sessionScope.staff != null}">
                        </c:when>
                        <c:otherwise>
                        <div class="center-div"><input type="submit" class="button" value="Book Now!" ></div>
                        </c:otherwise>
                    </c:choose>
            </div>
            <div class="sub-info">
                <h2 style="text-align: center; margin:20px auto; color: green;">Other Services</h2>
                <div class="other-service">
                    <a class="underlineHover" href="diagnose-examination">Diagnostic Examination</a><br>
                    <a class="underlineHover" href="veterinary-surgery" >Veterinary Surgery</a><br>
                    <a class="underlineHover" href="hair-trimming">Hair Trimming</a><br>
                    <a class="underlineHover" href="nutrient-consultation">Nutrients Consultation</a><br>
                    <a class="underlineHover" href="emergency">Emergency 24/7</a><br>
                </div>

            </div>
        </div>
        <br>
        <div class="contain-slider">
            <h1 style=" ;text-align: center; margin-bottom: -30px; padding: 30px; color: white; font-size: 70px;; font-weight: bold;  ">Review</h1>

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
                window.history.replaceState(null, null, "Vaccination.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/swiper-bundle.min.js"></script>
    <script src="js/script.js"></script>
</html>
