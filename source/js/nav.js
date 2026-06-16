document.addEventListener('click', function(e) {
  var toggle = document.getElementById('nav-toggle');
  if (!toggle || !toggle.checked) return;
  if (!e.target.closest('.site-header')) {
    toggle.checked = false;
  }
});
