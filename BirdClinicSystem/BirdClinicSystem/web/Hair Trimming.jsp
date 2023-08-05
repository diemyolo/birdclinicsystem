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
                    <img style="width: 100%" src="img/Banner-hair.png" alt=""/>
                </div>
            </div>
        </div>
        <div class="container-content">
            <div class="content-detail">
                <h2>Introduction</h2>
                <p>Our hair trimming services offer customers skilled and professional expertise to achieve their desired hair goals.
                    With a personalized approach, our team of experienced hairstylists or groomers delivers exceptional hair trimming services tailored to each customer's preferences.
                    Through attention to detail and a commitment to quality, we ensure that every hair trimming experience at our salon or grooming center results in a polished 
                    and well-groomed look. Choose our hair trimming services to transform
                </p>
                <h2>Skilled and Professional Hair Trimming</h2>
                <p>Highlight the expertise and professionalism of your hair trimming services. 
                    Emphasize that your team of skilled hairstylists or groomers are trained in the art of hair trimming, 
                    equipped with the knowledge of different cutting techniques and the ability to create various styles. 
                    Mention their experience in working with different hair types, textures, and lengths, ensuring that customers' hair goals are met with precision and care.
                </p>
                <h2>Personalized Hair Trimming Services</h2>
                <p>Showcase the personalized approach to hair trimming offered at your salon or grooming center. 
                    Explain that your professionals take the time to understand each customer's unique preferences and expectations. 
                    Whether it's a simple trim to maintain length, a stylish haircut, or a specific hairstyle, 
                    assure customers that their desired look will be achieved through personalized consultations and tailored hair trimming techniques.
                </p>               
                <h2>Attention to Detail and Quality</h2>
                <p> Highlight your commitment to attention to detail and delivering high-quality hair trimming services. 
                    Mention the use of professional-grade tools, including sharp scissors or precision clippers, to ensure clean and accurate cuts. 
                    Emphasize the focus on creating smooth transitions, even layers, and precise lines, resulting in a polished and well-groomed appearance.
                    Highlight any additional services offered, such as shampooing, conditioning, or styling, to provide customers with a comprehensive grooming experience.
                </p>
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
                    <a class="underlineHover" href="nutrient-consultation">Nutrients Consultation</a><br>
                    <a class="underlineHover" href="emergency">Emergency 24/7</a><br>
                    <a class="underlineHover" href="vaccination">Vaccination</a><br>
                    <a class="underlineHover" href="diagnose-examination" >Diagnostic Examination</a><br>
                    <a class="underlineHover" href="veterinary-surgery" >Veterinary Surgery</a><br>
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
                            <div class="card swiper-slide" style="border-radius: 25px">
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
                            <div class="card swiper-slide" style="border-radius: 25px">
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
                            <div class="card swiper-slide" style="border-radius: 25px">
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
                            <div class="card swiper-slide" style="border-radius: 25px">
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
                window.history.replaceState(null, null, "Hair Trimming.jsp");
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/swiper-bundle.min.js"></script>
    <script src="js/script.js"></script>
</html>
