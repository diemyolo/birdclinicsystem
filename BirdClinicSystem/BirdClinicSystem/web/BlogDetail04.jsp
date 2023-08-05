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
                <h1 class="title">Unmasking Common Avian Diseases and Prevention Strategies</h1>
                <div class="blogCreator">
                    <img src="img/user-icon.png" style="height: 30px;"/>
                    <h6>Henderson - 23/06/2023 11:46</h6> 
                </div>
                <div class="blog_img">
                    <img src="img/blog_detail_pic04.png"/>
                </div>

                <h2 style="margin-top: 1em;">Introduction</h2>
                <p style="font-weight: 600;">Birds are incredible creatures that grace our lives with their beauty and charm.
                    However, they are not immune to diseases that can impact their health and well-being. In this blog,
                    we delve into the world of avian diseases, shedding light on common ailments that affect birds and providing
                    essential prevention strategies. By understanding these diseases and taking proactive measures, you can protect
                    your feathered friends and ensure they lead healthy, vibrant lives.
                </p>
                <ol>
                    <li>
                        <strong>1. Understanding Avian Diseases:</strong>
                        <p>It's essential to educate yourself about common avian diseases that can affect birds, such as psittacosis, avian influenza, and polyomavirus. Learn about their symptoms, transmission routes, and potential risks to better recognize and prevent these illnesses.</p>
                    </li>
                    <li>
                        <strong>2. Maintaining Good Hygiene Practices:</strong>
                        <p>Practicing good hygiene is key to preventing the spread of diseases. Regularly clean and disinfect your bird's cage, perches, food and water dishes, and toys. Wash your hands thoroughly before and after handling your bird or any of its belongings to minimize the risk of cross-contamination.</p>
                    </li>
                    <li>
                        <strong>3. Providing a Nutritious Diet:</strong>
                        <p>A well-balanced and nutritious diet plays a vital role in supporting your bird's immune system. Consult with an avian veterinarian to ensure you are providing the right diet for your bird's specific species. Fresh fruits, vegetables, high-quality pellets, and limited seeds can help strengthen their immune system and overall health.</p>
                    </li>
                    <li>
                        <strong>4. Minimizing Stress:</strong>
                        <p>Stress can weaken a bird's immune system, making them more susceptible to diseases. Create a calm and safe environment for your bird, free from loud noises, excessive handling, and sudden changes. Provide them with ample opportunities for mental stimulation, social interaction, and a consistent daily routine.</p>
                    </li>
                    <li>
                        <strong>5. Regular Veterinary Check-ups:</strong>
                        <p>Schedule routine check-ups with an avian veterinarian to monitor your bird's health and detect any signs of illness early on. Vaccinations, regular examinations, and diagnostic tests can help identify and prevent diseases. Seek immediate veterinary care if you notice any abnormal behavior, changes in appetite, or other concerning symptoms.</p>
                    </li>
                    <li>
                        <strong>6. Preventing Contact with Wild Birds:</strong>
                        <p>Avoid direct or close contact between your pet bird and wild birds, as they can transmit diseases. Limit exposure to outdoor areas where wild birds congregate, and ensure that your bird's enclosure or aviary is secure and protected from potential contact with wild bird droppings or contaminated materials.</p>
                    </li>
                </ol>
                <h2>Conclusion</h2>
                <p class="conclusion">By understanding common avian diseases and implementing preventive strategies,
                    you can safeguard the health and well-being of your feathered companions. Stay vigilant, practice good hygiene,
                    provide a nutritious diet, minimize stress, and prioritize regular veterinary care. Your dedication to disease prevention
                    will help create a safe and thriving environment for your beloved birds, ensuring they lead long, healthy, and happy lives.</p>
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
                            <img src="img/Blog_pic 01.png"/> 
                            <a class="format" href="blog-detail-01">What Can You Do to Ensure Optimal Health and Happiness for Your Beloved Birds?</a>
                        </div>
                        <div class="blogIndex">
                            <img src="img/Blog_pic 02.png"/> 
                            <a class="format" href="blog-detail-02">How Regular Avian Veterinary Check-ups Keep Your Birds in Peak Condition</a>
                        </div>
                        <div class="blogIndex">
                            <img src="img/Blog_pic 03.png"/> 
                            <a class="format" href="blog-detail-03">A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety</a>
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
                window.history.replaceState(null, null, "BlogDetail04.jsp");
            }
        </script>
    </body>
</html>