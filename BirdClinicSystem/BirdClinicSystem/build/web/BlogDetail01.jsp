<%-- 
    Document   : BlogDetail
    Created on : May 28, 2023, 1:38:07 PM
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
        <link rel="stylesheet" href="style/blog_detail.css" type="text/css"/>
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
        
        <div class="blog_detail_body">
            <div class="blog_content">
                <h1 class="title">What Can You Do To Ensure Optimal Health and Happiness for Your Beloved Birds?</h1>
                <div class="blogCreator">
                    <img src="img/user-icon.png" style="height: 30px;"/>
                    <h6>Mary Johnson - 24/05/2023 18:39</h6> 
                </div>
                <div class="blog_img">
                    <img src="img/blog_detail_pic01.png" alt=""/>
                </div>

                <h2 style="margin-top: 1em;">Introduction</h2>
                <p style="font-weight: 600;">Birds are fascinating creatures that bring joy and beauty into our lives. 
                    As pet owners, it is our responsibility to ensure the well-being and happiness of our feathered friends.
                    In this blog, we will explore various ways to promote optimal health and happiness for your beloved birds,
                    creating a nurturing environment that allows them to thrive.
                </p>
                <ol>
                    <li>
                        <strong>1. Provide a Spacious and Stimulating Environment:</strong>
                        <p>Birds need ample space to fly, exercise, and explore. Ensure that their cage or aviary is appropriately sized, allowing them to spread their wings freely. Incorporate various perches, toys, and climbing structures to stimulate their physical and mental well-being. Rotating toys and introducing new ones periodically can prevent boredom and encourage playfulness.</p>
                    </li>

                    <li>
                        <strong>2. A Balanced and Nutritious Diet:</strong>
                        <p>Proper nutrition is essential for the overall health of your birds. Offer a diverse and balanced diet that includes high-quality bird pellets, fresh fruits, vegetables, and seeds. Consult with an avian veterinarian to determine the specific dietary requirements of your bird's species. Avoid feeding them toxic foods such as chocolate, caffeine, or avocado, which can be harmful.</p>
                    </li>

                    <li>
                        <strong>3. Hygiene and Cleanliness:</strong>
                        <p>Maintaining a clean and hygienic environment is crucial for your bird's health. Regularly clean their cage, food and water dishes, perches, and toys. Provide fresh, clean water daily, and ensure that the food is free from contamination. Good hygiene practices minimize the risk of infections and promote a healthy living environment.</p>
                    </li>

                    <li>
                        <strong>4. Social Interaction and Mental Stimulation:</strong>
                        <p>Birds are highly social creatures, and they thrive on interaction with their human companions. Spend quality time with your bird, engaging in gentle handling, talking, and playing. Provide opportunities for socialization with other birds if suitable. Additionally, offer mental stimulation through puzzle toys, foraging activities, and training exercises, which help keep their minds active and prevent boredom.</p>
                    </li>

                    <li>
                        <strong>5. Regular Veterinary Care:</strong>
                        <p>Routine veterinary check-ups are crucial to monitor your bird's health and detect any potential issues early on. Find an avian veterinarian who specializes in bird care and schedule regular visits. These check-ups allow for preventive care, vaccinations, and the opportunity to address any concerns or questions you may have about your bird's well-being.</p>
                    </li>

                    <li>
                        <strong>6. Environmental Considerations:</strong>
                        <p>Maintaining an optimal environment is vital for your bird's health and happiness. Avoid exposing them to drafts, extreme temperatures, or harmful fumes. Provide appropriate lighting conditions, as birds require exposure to natural light for their well-being. Avoid placing their cage near noisy areas or stressful environments, as they can negatively impact their overall mood and health.</p>
                    </li>
                </ol>
                <h2>Conclusion</h2>
                <p class="conclusion">Caring for your beloved birds is a rewarding responsibility that requires attention, love, and commitment. By providing a spacious and stimulating environment, a balanced diet, regular hygiene, social interaction, veterinary care, and an optimal living environment, you can ensure the optimal health and happiness of your feathered companions. Remember, a happy and healthy bird will bring you immeasurable joy and create a harmonious bond between you and your feathered friend.</p>
            </div>

            <div class="blog_sider">
                <!--                <div class="tool_box">
                                    <input type="text" class="search-input" placeholder="Search..."/>
                                    <button class="search-button">Search</button>
                                </div>-->

                <div class="category">
                    <h3>Category</h3>
                    <div class="divider"></div>
                    <h4>Basic Bird Care</h4>
                    <h4>Nutrition and Feeding</h4>
                    <h4>Health and Wellness</h4>
                    <h4>Veterinary Care and First Aid</h4>
                </div>

                <div class="recent_blog">
                    <h3>Recent blogs</h3>
                    <div class="divider"></div>
                    <div class="recent_blog_list">
                        <div class="blogIndex">
                            <img src="img/Blog_pic 02.png"/> 
                            <a class="format" href="blog-detail-02">How Regular Avian Veterinary Check-ups Keep Your Birds in Peak Condition</a>
                        </div>
                        <div class="blogIndex">
                            <img src="img/Blog_pic 03.png"/> 
                            <a class="format" href="blog-detail-03">A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety</a>
                        </div>
                        <div class="blogIndex">
                            <img src="img/Blog_pic 04.png"/> 
                            <a class="format" href="blog-detail-04">Unmasking Common Avian Diseases and Prevention Strategies</a>
                        </div>
                    </div>
                </div>
                <div class="vertical_banner">
                    <img src="img/bird_vertical_banner.png" style="width: 100%;"/>
                </div>
            </div>
        </div>
        <footer>
            <c:import url="footer.jsp"/>
        </footer>
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, "BlogDetail01.jsp");
            }
        </script>
    </body>
</html>