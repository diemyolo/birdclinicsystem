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
                    <img style="width: 100%" src="img/Banner (3).png" alt=""/>
                </div>
            </div>
        </div>
        <div class="container-content">
            <div class="content-detail">
                <h2>Introduction</h2>
                <p>Bird Nutrients Consultation offers expert guidance and tailored dietary recommendations to ensure the optimal nutrition of pet birds. 
                    Our experienced bird nutrition consultants provide personalized advice based on each bird's specific needs, species, and health conditions. 
                    By creating balanced and diverse diets, we support proper growth, vibrant plumage, strong immunity, and overall well-being in pet birds. 
                    Through our consultation services, we aim to educate bird owners on the fundamentals of bird nutrition, empowering them to make informed choices for the health
                    and longevity of their beloved feathered companions.
                </p>
                <h2>Expert Guidance on Bird Nutrition</h2>
                <p> Highlight the expertise and knowledge of your bird nutrition consultants. 
                    Explain that they possess in-depth understanding of the nutritional requirements of different bird species, including parrots, canaries, finches, 
                    and cockatiels. Mention their ability to provide personalized guidance based on factors such as age, species, activity level, and specific health conditions. 
                    Emphasize their expertise in creating balanced and diverse diets to meet the unique nutritional needs of pet birds.
                </p>
                <h2>Tailored Dietary Recommendations</h2>
                <p>Explain the importance of tailored dietary recommendations for pet birds. Discuss how the consultation process involves assessing the current diet, 
                    identifying any nutritional deficiencies or imbalances, and creating a customized feeding plan. Mention the inclusion of a variety of bird-friendly foods, 
                    such as seeds, pellets, fresh fruits, vegetables, and occasional treats. Highlight the focus on promoting proper growth, vibrant plumage, strong immune function,
                    and overall well-being through a balanced and nutritious diet.
                </p>               
                <h2>Education on Bird Nutrition</h2>
                <p>Emphasize the educational aspect of the consultation. Mention that the consultants not only provide specific dietary recommendations 
                    but also educate bird owners on the fundamentals of bird nutrition. This includes information on essential nutrients, feeding practices, portion control, 
                    and potential dietary hazards to avoid. By empowering bird owners with knowledge, they can make informed decisions regarding their birds' diet 
                    and actively contribute to their birds' health and happiness.</p>
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
                    <a class="underlineHover" href="emergency">Emergency 24/7</a><br>
                    <a class="underlineHover" href="vaccination">Vaccination</a><br>
                    <a class="underlineHover" href="diagnose-examination" >Diagnostic Examination</a><br>
                    <a class="underlineHover" href="veterinary-surgery" >Veterinary Surgery</a><br>
                    <a class="underlineHover" href="hair-trimming">Hair Trimming</a><br>
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
                window.history.replaceState(null, null, "Nutrient Consultation.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/swiper-bundle.min.js"></script>
    <script src="js/script.js"></script>
</html>
