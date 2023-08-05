<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaScript Chatbot</title>

    <!-- css file link -->
    <link rel="stylesheet" href="ChatBot/style.css">

    <!-- font awesome icon cdn-->
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    
    <button id="init">START CHAT</button>
    <div id="test">
        <div class="child" id="chatbot">
            <div class="header">
                <div class="h-child">
                    <img src="img/pl 1.png" alt="avatar" id="avatar">
                    <div>
                        <div class="name">Bird Clinic System</div>                       
                        <div style="color:lawngreen">Online</div>
                    </div>
                </div>
                <div>
                    <button class="refBtn"><i class="fa fa-refresh" onclick="initChat()"></i></button>
                </div>
            </div>

            <div id="chat-box">

            </div>
            <div class="footer-chat">
                <span>"Flying Healthier Futures"</span>
            </div>
        </div>
    </div>

    <!-- js file  -->
    <script src="ChatBot/script.js"></script>
</body>
</html>