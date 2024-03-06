
const enableSharing = function () {
    function showIcon(e, sel) {
        const icon = e.querySelector(sel);
        if (icon) {
            icon.style.display = "block";
        }
    }

    if (!navigator.share) {
        return;
    }

    document.querySelectorAll(".share").forEach(function(t) {
        if (navigator.userAgent.includes("Android")) {
            showIcon(t, ".aos");
        } else {
            showIcon(t, ".ios");
        }

        t.style.display = "block";
        t.addEventListener("click", function(e) {
            navigator.share({
                url: window.location.href,
                title: "Sharing - " + t.getAttribute("article"),
                text: "I found this article at DWF's Journal and thought you might like it."
            });
        });
    });
}
enableSharing();