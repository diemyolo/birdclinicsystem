var data = {
    chatinit: {
        title: ["Hello <span class='emoji'> &#128075;</span>", "Welcome to our chat bot! We're delighted to have you here. Whether you're seeking information, assistance, or just want to engage in a friendly conversation, our chat bot is here to help. Feel free to ask any questions or share your thoughts, and we'll do our best to provide you with accurate and relevant responses", "How can I help you?"],
        options: ["Services", "News", "Doctors", "Login"]
    },
    services: {
        title: ["Please select Services"],
        options: ['Vaccination', 'Diagnostic Examination', 'Vet Surgery', 'Others'],
        url: {
            link: ["Vaccination.jsp", "Diagnose%20Examination.jsp", "Veterinary%20Surgery.jsp", "ServiceList.jsp"]
        }
    },

    doctors: {
        title: ["Having experienced the care and expertise of this doctor firsthand, I can confidently say they are a true gem in the medical field. Their knowledge, compassion, and dedication to their patients are truly commendable"],
        options: ["See Our Doctor"],
        url: {
            link: ["MainController?action=viewPaginatedDoctor&page=1"]
        }
    },
    news: {
        title: ["Thanks for your response", "Here are some blogs where we share some 'tips and tricks' for our beloved friends - our pets ", "Please select one of the below options to proceed further"],
        options: ['What Can You Do To Ensure Optimal Health and Happiness for Your Beloved Birds?', 'A Safe Haven in Your Home: Essential Tips for Bird-Proofing and Ensuring Safety', 'How Regular Avian Veterinary Check-ups Keep Your Birds in Peak Condition', 'Unmasking Common Avian Diseases and Prevention Strategies'],
        url: {
            link: ["blog-detail-01", "blog-detail-03", "blog-detail-02", "blog-detail-04"]

        }
    },
    login: {
        title: ["Thanks for your response", "hmmm...Do you want to login or register"],
        options: ['Login', 'Register'],
        url: {
            link: ["login", "sign-up", ]
        }
    },
    
}

document.getElementById("init").addEventListener("click", showChatBot);
var cbot = document.getElementById("chat-box");

var len1 = data.chatinit.title.length;

function showChatBot() {

    console.log(this.innerText);
    if (this.innerText == 'START CHAT') {
        document.getElementById('test').style.display = 'block';
        document.getElementById('init').innerText = 'CLOSE CHAT';
        initChat();
    } else {
        document.getElementById('test').style.display = 'none';
        document.getElementById('init').innerText = 'START CHAT';
    }
}

function initChat() {
    j = 0;
    cbot.innerHTML = '';
    for (var i = 0; i < len1; i++) {
        setTimeout(handleChat, (i * 500));
    }
    setTimeout(function () {
        showOptions(data.chatinit.options)
    }, ((len1 + 1) * 500))
}

var j = 0;
function handleChat() {
    console.log(j);
    var elm = document.createElement("p");
    elm.innerHTML = data.chatinit.title[j];
    elm.setAttribute("class", "msg");
    cbot.appendChild(elm);
    j++;
    handleScroll();
}

function showOptions(options) {
    for (var i = 0; i < options.length; i++) {
        var opt = document.createElement("span");
        var inp = '<div>' + options[i] + '</div>';
        opt.innerHTML = inp;
        opt.setAttribute("class", "opt");
        opt.addEventListener("click", handleOpt);
        cbot.appendChild(opt);
        handleScroll();
    }
}

function handleOpt() {
    console.log(this);
    var str = this.innerText;
    var textArr = str.split(" ");
    var findText = textArr[0];

    document.querySelectorAll(".opt").forEach(el => {
        el.remove();
    })
    var elm = document.createElement("p");
    elm.setAttribute("class", "test");
    var sp = '<span class="rep">' + this.innerText + '</span>';
    elm.innerHTML = sp;
    cbot.appendChild(elm);

    console.log(findText.toLowerCase());
    var tempObj = data[findText.toLowerCase()];
    handleResults(tempObj.title, tempObj.options, tempObj.url);
}

function handleDelay(title) {
    var elm = document.createElement("p");
    elm.innerHTML = title;
    elm.setAttribute("class", "msg");
    cbot.appendChild(elm);
}


function handleResults(title, options, url) {
    for (let i = 0; i < title.length; i++) {
        setTimeout(function () {
            handleDelay(title[i]);
        }, i * 500)

    }

    const isObjectEmpty = (url) => {
        return JSON.stringify(url) === "{}";
    }

    if (isObjectEmpty(url) == true) {
        console.log("having more options");
        setTimeout(function () {
            showOptions(options);
        }, title.length * 500)

    } else {
        console.log("end result");
        setTimeout(function () {
            handleOptions(options, url);
        }, title.length * 500)

    }
}

function handleOptions(options, url) {
    for (var i = 0; i < options.length; i++) {
        var opt = document.createElement("span");
        var inp = '<a id="pop-link" class="m-link" target="_blank"href="' + url.link[i] + '">' + options[i] + '</a>';
        opt.innerHTML = inp;
        opt.setAttribute("class", "opt");
        cbot.appendChild(opt);
    }

    const isObjectEmpty = (url) => {
        return JSON.stringify(url) === "{}";
    }
    

    handleScroll();
}
//href="' + url.link[i] + '"
function handleScroll() {
    var elem = document.getElementById('chat-box');
    elem.scrollTop = elem.scrollHeight;
}























