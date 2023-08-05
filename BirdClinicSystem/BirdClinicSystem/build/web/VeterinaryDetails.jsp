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
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/serviceDetail.css" rel="stylesheet">
        <link rel="stylesheet" href="css/swiper-bundle.min.css">
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.user == null}">
                <c:import url="header.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="headerUser.jsp"/>
            </c:otherwise>
        </c:choose>

        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel1 pictureCarusel ">                   
                </div>
            </div>
        </div>
        <div class="container-content">
            <div class="content-detail">
                <p>Veterinary surgery is a vital aspect of animal healthcare, 
                    offering specialized expertise and comprehensive surgical services to address a variety of medical conditions in animals. 
                    By showcasing the expertise of veterinary surgeons, emphasizing the range of surgical procedures offered, 
                    and highlighting the commitment to compassionate care and patient safety, customers can feel confident entrusting their pets to your veterinary practice. 
                    Veterinary surgery plays a crucial role in improving the quality of life for animals, and by providing a clear and informative website, 
                    you can help customers understand the importance and benefits of veterinary surgical services for their beloved pets.                   
                </p>
                <h2>Expertise and Specialization</h2>
                <p>Veterinary surgery showcases the advanced knowledge and specialized skills of veterinarians in performing surgical procedures on animals. 
                    Highlight the extensive training and experience of the veterinary surgeons at your practice, emphasizing their expertise in various surgical techniques,
                    such as soft tissue surgery, orthopedics, and minimally invasive procedures. 
                    Assure customers that your veterinary surgeons stay up-to-date with the latest advancements in surgical practices to provide the highest level of care.
                </p>
                <h2>Comprehensive Surgical Services</h2>
                <p>Explain the range of surgical services offered at your veterinary practice. Mention the ability to perform both routine and complex surgeries, 
                    including spay/neuter procedures, tumor removals, fracture repairs, joint surgeries, and emergency surgeries. 
                    Emphasize the use of state-of-the-art equipment and modern surgical techniques to ensure safe and effective procedures.
                </p>               
                <p>Highlight any additional services such as pre-surgical consultations, post-operative care, 
                    and pain management protocols to demonstrate your commitment to comprehensive patient care.</p>
                <h2>Compassionate Care and Patient Safety</h2>
                <p>Assure customers that their beloved pets will receive compassionate care throughout the surgical process. 
                    Mention that your veterinary practice prioritizes patient safety by following strict protocols, including thorough pre-operative assessments, advanced anesthesia monitoring, 
                    and a sterile surgical environment. Highlight the availability of post-operative pain management and attentive post-operative care to promote a smooth recovery. 
                    Reinforce the collaborative approach with pet owners, emphasizing the importance of clear communication and addressing any concerns they may have.</p>
                <div class="center-div"><input type="submit" class="button" value="Book Now!" ></div>
            </div>
            <div class="sub-info">
                <h2 style="text-align: center; margin:20px auto; color: green;">Other Services</h2>
                <div class="other-service">
                    <a class="underlineHover" href="hair-trim-details">Hair Trimming</a><br>
                    <a class="underlineHover" href="nutrients-details">Nutrients Consultation</a><br>
                    <a class="underlineHover" href="emergency-details">Emergency 24/7</a><br>
                    <a class="underlineHover" href="vaccination-details">Vaccination</a><br>
                    <a class="underlineHover" href="diagnostic-details" >Diagnostic Examination</a><br>
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

    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/swiper-bundle.min.js"></script>
    <script src="js/script.js"></script>
</html>
