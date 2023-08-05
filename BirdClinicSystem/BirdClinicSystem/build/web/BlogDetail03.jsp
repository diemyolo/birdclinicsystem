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
                <h1 class="title">A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety</h1>
                <div class="blogCreator">
                    <img src="img/user-icon.png" style="height: 30px;"/>
                    <h6>Henderson - 19/05/2023 17:23</h6> 
                </div>
                <div class="blog_img">
                    <img src="img/blog_detail_pic03.png" alt"/>
                </div>

                <h2 style="margin-top: 1em;">Introduction</h2>
                <p style="font-weight: 600;">When you bring birds into your home, their safety becomes a top priority.
                    Creating a bird-safe environment is crucial to prevent accidents and provide a secure haven for your feathered companions.
                    In this blog, we will discuss essential precautions and measures to bird-proof your home, ensuring the well-being and protection
                    of your cherished avian friends. By following these guidelines, you can enjoy a harmonious and worry-free coexistence
                    with your beloved birds.</p>
                <ol>
                    <li>
                        <strong>1. Eliminate Potential Hazards:</strong>
                        <p>Inspect your home for any potential hazards that could endanger your bird's safety. Remove toxic plants, as many common household plants can be harmful if ingested. Keep electrical cords and wires out of reach or cover them with protective tubing. Secure windows and doors to prevent accidental escapes. Seal off access to small spaces where your bird could get stuck.</p>
                    </li>
                    <li>
                        <strong>2. Choose Bird-Safe Materials:</strong>
                        <p>When selecting materials for your bird's cage or play area, opt for bird-safe options. Avoid cages with toxic coatings or paints that could be harmful if chewed. Choose stainless steel or powder-coated cages instead. Use natural and non-toxic perches, toys, and accessories to prevent any potential harm to your bird.</p>
                    </li>
                    <li>
                        <strong>3. Beware of Teflon and Other Fumes:</strong>
                        <p>Avoid using non-stick cookware, as the fumes released from overheating Teflon can be extremely toxic to birds. Keep your bird away from the kitchen when cooking or using cleaning products with strong fumes. Use bird-safe cleaning products to ensure the environment remains free from harmful chemicals.</p>
                    </li>
                    <li>
                        <strong>4. Secure Open Flames and Heat Sources:</strong>
                        <p>Keep your bird away from open flames, candles, and space heaters. Birds are curious and may fly too close, risking burns or accidents. Use flameless candles or bird-safe heat sources if needed. Ensure that any heating or cooling systems in your home are well-maintained and do not produce drafts that could negatively affect your bird's health.</p>
                    </li>
                    <li>
                        <strong>5. Be Mindful of Ceiling Fans and Windows:</strong>
                        <p>Always be cautious when operating ceiling fans with your bird around. Avoid letting your bird fly freely in rooms with ceiling fans turned on. Keep windows and balcony doors closed or install protective screens to prevent accidental collisions or escapes.</p>
                    </li>
                    <li>
                        <strong>6. Provide Adequate Supervision:</strong>
                        <p>Never leave your bird unattended outside of its cage, especially in unfamiliar areas. Supervise your bird's interactions with other pets or children to prevent any potential accidents or injuries. Always be present and attentive to ensure their safety.</p>
                    </li>
                </ol>
                <h2>Conclusion</h2>
                <p class="conclusion">Creating a safe haven for your beloved birds is essential for their well-being.
                    By bird-proofing your home and implementing these essential safety tips, you can provide a secure environment
                    where your feathered companions can thrive. Remember, their safety is in your hands, and a protected and secure space will
                    contribute to their happiness and strengthen the bond between you and your avian friends.</p>

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
                window.history.replaceState(null, null, "BlogDetail03.jsp");
            }
        </script>
    </body>
</html>