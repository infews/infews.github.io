enableSharing = function () {

    if (!navigator.share) {
        return;
    }

    document.querySelectorAll(".share").forEach(function(t) {
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