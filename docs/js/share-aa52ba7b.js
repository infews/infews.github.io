enableSharing=function(){if(!navigator.share)return void console.log("navigator.share not found");document.querySelectorAll(".share").forEach(function(n){console.log("Showing share button"),n.style.display="block",console.log("Adding onclick"),n.addEventListener("click",function(){navigator.share({url:window.location.href,title:"Sharing - "+n.getAttribute("article"),text:"I found this article at DWF's Journal and thought you might like it."})})})},enableSharing();