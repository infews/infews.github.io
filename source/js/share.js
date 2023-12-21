enableSharing = function () {

    if (!navigator.share) {
        return;
    }

    document.querySelectorAll(".share").forEach((t) => {
        t.addEventListener("click", (e) => {
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