/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function switchAttribute(){
    var button = document.getElementById("myButton");
    var currentValue = button.getAttribute("value");

    if (currentValue === "getBirdsNameDesc") {
        button.setAttribute("value", "getBirdsNameAsc");
    } else {
        button.setAttribute("value", "getBirdsNameDesc");
    }
}

