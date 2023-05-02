<script>
// open rdrr links externally ----

var exlinks = document.querySelectorAll("a[href^='https://rdrr.io']");
var exlink_func = function(){
  window.open(this.href);
  return false;
};
for (var i = 0; i < exlinks.length; i++) {
    exlinks[i].addEventListener('click', exlink_func, false);
}

// visible second sidebar in mobile ----

function move_sidebar() {
  var toc = document.getElementById("TOC");
  var small_sidebar = document.querySelector("#quarto-sidebar .sidebar-menu-container");
  var right_sidebar = document.getElementById("quarto-margin-sidebar");

  if (window.innerWidth < 768) {
    small_sidebar.append(toc);
  } else {
    right_sidebar.append(toc);
  }
}
move_sidebar();
window.onresize = move_sidebar;
</script>