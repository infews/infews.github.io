enableSharing = function () {

    if (!navigator.share) {
        console.log("navigator.share not found");
        return;
    }

    document.querySelectorAll(".share").forEach(function(t) {
        console.log("Adding onclick");
        t.addEventListener("click", function(e) {
            t.style.display = "block;";
            navigator.share({
                url: window.location.href,
                title: "Sharing - " + t.getAttribute("article"),
                text: "I found this article at DWF's Journal and thought you might like it."
            });
        });
    });
}
enableSharing();