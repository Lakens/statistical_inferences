<script>
$( document ).ready(function() {
  var cite = ' ';
  var license = ' <a rel="license" href="https://creativecommons.org/licenses/by-nc-sa/4.0/" target="blank"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png"></a>';

  $("footer div.row div:eq(1) p").html(
    license + cite
  );

  function move_sidebar() {
    var w = window.innerWidth;
    if (w < 992) {
      $("#toc").appendTo($("#main-nav"));
    } else {
      $("#toc").appendTo($("div.sidebar-chapter"));
    }
  }
  move_sidebar();
  window.onresize = move_sidebar;
});
</script>
