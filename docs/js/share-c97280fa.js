const enableSharing=function(){function t(t,e){const n=t.querySelector(e);n&&(n.style.display="inline")}navigator.share&&document.querySelectorAll(".share").forEach(function(e){navigator.userAgent.includes("Android")?t(e,".aos"):t(e,".ios"),e.style.display="block",e.addEventListener("click",function(){navigator.share({url:window.location.href,title:"Sharing - "+e.getAttribute("article"),text:"I found this article at DWF's Journal and thought you might like it."})})})};enableSharing();