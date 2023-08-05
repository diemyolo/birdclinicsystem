<%-- 
    Document   : BlogList
    Created on : May 25, 2023, 6:54:19 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bird Clinic System</title>
        <link rel="icon" type="image/x-icon" href="img/pl 1.png">
        <link rel="stylesheet" href="style/blog_list.css" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    </head>
    <body>
        <!-- Check if logined -->
        <c:choose>
            <c:when test="${sessionScope.customer != null}">
                <c:import url="headerUser.jsp"/>
            </c:when>
            <c:otherwise>
                <c:import url="header.jsp"/>
            </c:otherwise>
        </c:choose>
        <div class="banner">
            <h1>Our blogs</h1>
            <h5>Feathers & Healing: Fly into our Blog List and Soar with Avian Wisdom!</h5>
        </div>
        <div class="tool_box">
                <input type="text" class="search-input" placeholder="Search..."/>
                <button class="search-button">Search</button>
        </div>
        <div class="blogListBody">

            <div class="blogIndex">
                <a href="blog-detail-01"><img src="img/Blog_pic 01.png"/></a>
                <div class="blogDescription">
                    <div class="blogCreator">
                        <img src="img/user-icon.png"/>
                        <h6>My name - Date</h6> 
                    </div>
                    <h2><a href="blog-detail-01">What Can You Do to Ensure Optimal Health and Happiness for Your Beloved Birds?</a></h2>
                    <div class="divider"></div>
                    <p>Embark on a journey to uncover the secrets of avian well-being and explore actionable steps to provide the best care for your cherished avian companions.
                        From understanding their nutritional needs to creating enriching environments, these informative blog posts will delve into the depths of bird health,
                        leaving you equipped with knowledge and strategies to keep your feathered friends thriving.
                    </p>
                    <a href="blog-detail-01"><h6>Read more...</h6></a>
                </div>
            </div>

            <div class="blogIndex">
                <a href="blog-detail-02"><img src="img/Blog_pic 02.png"/></a>
                <div class="blogDescription">
                    <div class="blogCreator">
                        <img src="img/user-icon.png"/>
                        <h6>My name - Date</h6> 
                    </div>
                    <h2><a href="blog-detail-02">How Regular Avian Veterinary Check-ups Keep Your Birds in Peak Condition</a></h2>
                    <div class="divider"></div>
                    <p>Embark on a journey to uncover the secrets of avian well-being and explore actionable steps to provide the best care for your cherished avian companions.
                        From understanding their nutritional needs to creating enriching environments, these informative blog posts will delve into the depths of bird health,
                        leaving you equipped with knowledge and strategies to keep your feathered friends thriving.
                    </p>
                    <a href="blog-detail-02"><h6>Read more...</h6></a>
                </div>
            </div>
            
            <div class="blogIndex">
                <a href="blog-detail-03"><img src="img/Blog_pic 03.png"/></a>
                <div class="blogDescription">
                    <div class="blogCreator">
                        <img src="img/user-icon.png"/>
                        <h6>My name - Date</h6> 
                    </div>
                    <h2><a href="blog-detail-03">A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety</a></h2>
                    <div class="divider"></div>
                    <p>Embark on a journey to uncover the secrets of avian well-being and explore actionable steps to provide the best care for your cherished avian companions.
                        From understanding their nutritional needs to creating enriching environments, these informative blog posts will delve into the depths of bird health,
                        leaving you equipped with knowledge and strategies to keep your feathered friends thriving.
                    </p>
                    <a href="blog-detail-03"><h6>Read more...</h6></a>
                </div>
            </div>
            
            <div class="blogIndex">
                <a href="blog-detail-04"><img src="img/Blog_pic 04.png"/>   </a>
                <div class="blogDescription">
                    <div class="blogCreator">
                        <img src="img/user-icon.png"/>
                        <h6>My name - Date</h6> 
                    </div>
                    <h2><a href="blog-detail-04">Unmasking Common Avian Diseases and Prevention Strategies</a></h2>
                    <div class="divider"></div>
                    <p>Embark on a journey to uncover the secrets of avian well-being and explore actionable steps to provide the best care for your cherished avian companions.
                        From understanding their nutritional needs to creating enriching environments, these informative blog posts will delve into the depths of bird health,
                        leaving you equipped with knowledge and strategies to keep your feathered friends thriving.
                    </p>
                    <a href="blog-detail-04"><h6>Read more...</h6></a>
                </div>
            </div>

        </div>

        <div class="footer">
            <c:import url="footer.jsp"/>
        </div>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "blog-list");
            }
        </script>
    </body>
</html>
