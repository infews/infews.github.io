enableSharing = function() {
    target = document.querySelector("i.share");

    if (!target) {
        return;
    }

    addShareEvent = function() {
        share_data = {
            url: window.location.href,
            title: "Sharing - " + target.getAttribute("article"),
            text: "I found this article at DWF's Journal and thought you might like it."
        };
        target.addEventListener("click", function (e) {
            if (!navigator.share) {
                window.alert("Please enable web sharing to share this article");
                return;
            }
            navigator.share(share_data);
        });
    }
    addShareEvent();
}
enableSharing();