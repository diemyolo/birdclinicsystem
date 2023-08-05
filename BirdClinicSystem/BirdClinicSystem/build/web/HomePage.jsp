<%-- 
    Document   : HomePage
    Created on : May 23, 2023, 12:01:32 PM
    Author     : Admin
--%>
<%@page import="DAO.AppointmentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAO.FeedbackDAO"%>
<%@page import="DTO.Feedback"%>
<%@page import="DAO.CustomersDAO"%>
<%@page import="DTO.Customers"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <c:set var="updateStatus" value="${AppointmentDAO.updateAppStatus()}"/>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.customer != null}">
                <c:import url="headerUser.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="header.jsp"/>
            </c:otherwise>
        </c:choose>
         <%@include file="ChatBot.jsp" %>
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img style="height: 550px; width: 100%" class="d-block w-100" src="img/Banner_bird.png" alt=""/>
                </div>
                <div class="carousel-item">
                    <img style="height: 550px; width: 100%" class="d-block w-100" src="img/hero.jpg" alt="Second slide">
                </div>

                <div class="carousel-item">
                    <img style="height: 550px; width: 100%" class="d-block w-100" src="img/bird_slide_03.png" alt="Third slide">
                </div>

            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <br>
        <div class="container-fluid">
            <div class="about-us" style=" height: 900px;">
                <div class="text-about" style="display: flex; justify-content:flex-end ; margin-top: 70px; margin-bottom: -30px;">
                    <h1>About Us</h1>
                    <div class="line" style="border-left: 6px solid green; height: 60px; margin-left: 16px;"></div>  
                </div>
                <br>
                <div class="container">
                    <div class="tag item appear2">
                        <div class=""> <img style="height: 200px;  border-radius: 20px 0px 0px 20px; " src="img/about_us_1.jpg" alt=""/></div>          
                        <div class="content" style="padding: 20px">We offer specialty medicine for pets. In the city that never sleeps, our hospital keeps pace with you and your pets,
                            and are open 24 hours a day for pet emergencies. With expertise drawn from years of advanced training,
                            our veterinarians tackle some of the toughest medical and surgical conditions. 
                            Our specialists use innovative procedures, combined with traditional, proven methods, high-tech equipment and the latest medicines and to diagnose and treat your pet’s condition</div>
                    </div>
                    <div class="tag item appear2" >
                        <div class="content" style="padding: 20px">We are committed to providing comprehensive, 
                            quality care for each patient to enhance their well-being and quality of life. 
                            Our compassionate, knowledgeable and professional team utilizes state of the art technology and
                            is continually implementing the latest innovations in cutting edge medical practices.
                            We truly value your opinion in the decision making process. Our ability to foster an educational 
                            experience to address your individual needs is second to none.</div
                        <div class=""> <img style="height: 200px; border-radius: 0px 20px 20px 0px;" src="img/about_us_2.jpg" alt=""/>
                        </div>

                        <div class="tag item appear2">
                            <div class=""> <img style="height: 200px; border-radius: 20px 0px 0px 20px; " src="img/about_us_3.jpg" alt=""/></div>          
                            <div class="content" style="padding: 20px">Our team’s goal is simple: create and deliver a treatment plan that best meets your pet’s medical needs and your expectations.
                                Whether your veterinarian referred your pet to us because of an emergency situation or 
                                due to a chronic illness, our skilled team is ready to provide the highest quality care and attention 
                                for your pet.</div>
                        </div>
                    </div>
                </div>         
                <div class="service-block" style=" height: 900px; margin-top: 100px;">
                    <div class="text-about service" style="display: flex; justify-content:flex-start ; margin-bottom: 30px; margin-left: 20px">
                        <div class="line" style="border-left: 6px solid green; height: 60px; margin-right: 16px; "></div>
                        <h1>Services</h1>
                    </div>
                    <div class="service-content" >
                        <div class="catagories">
                            <img src="img/bird_vaccine_4 1.png" alt=""/>
                            <div class="line1"></div>
                            <h2>Vaccination</h2>
                        </div>
                        <div class="catagories">                       
                            <img src="img/bird_examine_2.png" alt=""/>
                            <div class="line1" style="width: 90%"></div>
                            <h2>Diagnostic Examination</h2>
                        </div>                    

                        <div class="catagories">
                            <img src="img/vet_surgery.png" alt=""/>
                            <div class="line1" style="width: 85%"></div>
                            <h2>Veterinary Surgery</h2>
                        </div>                 

                        <div class="catagories">
                            <img src="img/bird_cutting_hair 1.png" alt=""/>
                            <div class="line1" style="width: 70%"></div>
                            <h2>Hair Trimming</h2>
                        </div>
                        <div class="catagories">
                            <img src="img/bird_nutrients 1.png" alt=""/>
                            <div class="line1" style="width: 90%"></div>
                            <h2>Nutrients Consultation</h2>
                        </div>
                        <div class="catagories">
                            <img src="img/7 1.png" alt=""/>
                            <div class="line1" style="width: 90%"></div>
                            <h2>Emergency</h2>
                        </div>
                    </div>
                </div>
                <div class="blog-container">
                    <div class="text-about" style="display: flex; justify-content:flex-end ; margin-top: 150px; margin-bottom: -30px;">
                        <h1>Blogs</h1>
                        <div class="line" style="border-left: 6px solid green; height: 68px; margin-left: 16px; "></div>  
                    </div>
                    <div class="line2"></div>
                    <div class="blog-content">
                        <div class="blog">
                            <div>
                                <img style="width: 100%;" src="img/Blog_pic 01.png" alt=""/>
                            </div>
                            <a href='blog-detail-01' style="text-decoration: none; color: black;"><h5>How Regular Avian Veterinary Check-ups Keep Your Birds in Peak Condition</h5></a>

                            <div class="line2 cata" style="box-shadow: none;"></div>
                            <p>Embark on a journey to uncover the secrets of avian well-being and explore actionable steps to provide the best care for your cherished avian companions.
                        From understanding their nutritional needs to creating enriching environments,[...]</p>
                        </div>
                        <div class="blog">
                            <div >
                                <img src="img/Blog_pic 02.png" alt=""/> 
                            </div>
                            <a href='blog-detail-02' style="text-decoration: none; color: black;"><h5>What Can You Do to Ensure Optimal Health and Happiness for Your Beloved Birds?</h5></a>

                            <div class="line2 cata" style="box-shadow: none;"></div>
                            <p>Birds are remarkable creatures that captivate our imaginations with their beauty and grace. With their ability to soar through the sky, they bring a sense of freedom and wonder to the world.[…] </p>
                        </div>
                        <div class="blog">
                            <div >
                                <img src="img/Blog_pic 03.png" alt=""/> 
                            </div>
                            <a href='blog-detail-03' style="text-decoration: none; color: black;"><h5>A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety</h5></a>
                            <div class="line2 cata" style="box-shadow: none;"></div>
                            <p>From the vibrant plumage of tropical parrots to the intricate patterns on the wings of hummingbirds, each bird species showcases its unique charm. Birds are not only aesthetically pleasing, but they also play a vital role in maintaining our ecosystem[…]</p>
                        </div>                 
                        <div class="blog">
                            <div >
                                <img src="img/Blog_pic 04.png" alt=""/>
                            </div>
                            <a href='blog-detail-04' style="text-decoration: none; color: black;"><h5>Unmasking Common Avian Diseases and Prevention Strategies</h5></a>

                            <div class="line2 cata" style="box-shadow: none;"></div>
                            <p>Their melodic songs fill the air, creating a symphony of nature's melodies. Whether observed in the wild or cherished as beloved pets, birds continue to amaze us with their elegance and remind us of the incredible diversity of life on Earth[…]</p>
                        </div>
                    </div>
                </div>
                <div class="feedback">
                    <div class="text-about service" style="display: flex; justify-content:flex-start ; margin-bottom: 20px; margin-left: 10px;">
                        <div class="line" style="border-left: 6px solid green; height: 65px; margin-left: 16px; "></div>
                        <h1 style="margin-left: 10px">Feedback</h1>
                    </div>
                    <div class="feedback-container">
                        <h1 style="text-align: center; padding-top: 20px; padding-bottom: 10px; font-size: 60px; word-spacing: 5px; ">Testimonials</h1>
                        <div class="owner-grid">
                            <c:forEach var="feedback" items="${FeedbackDAO.getAllFeedback()}" varStatus="status">
                            <c:set var="customer" value="${CustomersDAO.getUserByCusID(feedback.cusID)}"></c:set>
                            <div class="quote">
                                <div class="happy-owner">
                                    <img src="${customer.image == null ? 'img/user-icon.png' : customer.image}" alt=""/>
                                    <h3>${customer.fullname}</h3>
                                </div>  
                                <div>
                                    <div class="owner-content"> "We really like Dr. Smith.
                                        He takes his time with Kelly and answers all of our questions.
                                        We never feel rushed during our appointment and he does not recommend unneeded tests.
                                        He answers our phone calls very quickly. We are in good hands with Dr. Smith."</div>
                                    <c:choose>
                                    <c:when test="${feedback.rating > 0}">
                                    <div class="star">
                                        <c:forEach var="i" begin="1" end="${feedback.rating}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        </c:forEach>
                                    </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Display a message or fallback content when rating is 0 or negative -->
                                        No rating available.
                                    </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>
                            </c:forEach>

                            <div class="quote">
                                <div class="happy-owner">
                                    <img src="img/bird_owner.jpg" alt=""/>
                                    <h3>Ellie</h3>
                                    <p>Happy Client</p>
                                </div>  
                                <div>
                                    <div class="owner-content"> "Doctors are a highly skilled and dedicated professional.
                                        They go above and beyond to stay updated on the latest advancements in medicine and continuously strive to provide the best possible care for their patients. 
                                        I am grateful for their expertise and commitment to my well-being."</div>
                                    <div class="star">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="yellow" class="bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            

                        </div>
                    </div>
                </div>
            </div>
            <header>
                <c:import url="footer.jsp"/>
            </header>

    </body>

</html>
