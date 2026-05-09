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

// move TOC title to left sidebar and inject current chapter sections ----

function move_sidebar() {
  var toc = document.getElementById("TOC");
  var sidebar_menu = document.querySelector("#quarto-sidebar .sidebar-menu-container");
  var chapter_list = document.querySelector("#quarto-sidebar .sidebar-menu-container ul.mt-1");

  if (!toc || !sidebar_menu || !chapter_list) {
    return;
  }

  var previous = chapter_list.querySelectorAll("li.sidebar-item.toc-injected");
  for (var i = 0; i < previous.length; i++) {
    previous[i].remove();
  }

  chapter_list.insertAdjacentElement("afterend", toc);

  var active_link = chapter_list.querySelector("a.sidebar-link.active");
  if (!active_link) {
    return;
  }

  var active_item = active_link.closest("li.sidebar-item");
  if (!active_item) {
    return;
  }

  var toc_links = toc.querySelectorAll(":scope > ul > li > a.nav-link");
  var anchor = active_item;

  for (var j = 0; j < toc_links.length; j++) {
    var toc_link = toc_links[j];
    var li = document.createElement("li");
    li.className = "sidebar-item toc-injected";

    var container = document.createElement("div");
    container.className = "sidebar-item-container";

    var link = document.createElement("a");
    link.className = "sidebar-item-text sidebar-link";
    link.href = toc_link.getAttribute("href");
    link.textContent = toc_link.textContent.trim();

    container.appendChild(link);
    li.appendChild(container);
    anchor.insertAdjacentElement("afterend", li);
    anchor = li;
  }
}

move_sidebar();
window.addEventListener("resize", move_sidebar);

// accessibility toggles in top navbar ----

function apply_accessibility_preferences() {
  var body = document.body;
  if (!body) {
    return;
  }

  var dyslexic_on = localStorage.getItem("si-dyslexic-font") === "true";
  var contrast_on = localStorage.getItem("si-high-contrast") === "true";

  body.classList.toggle("dyslexic-font", dyslexic_on);
  body.classList.toggle("high-contrast", contrast_on);

  var dyslexic_btn = document.getElementById("toggle-dyslexic-font");
  var contrast_btn = document.getElementById("toggle-high-contrast");

  if (dyslexic_btn) {
    dyslexic_btn.setAttribute("aria-pressed", String(dyslexic_on));
    dyslexic_btn.classList.toggle("is-active", dyslexic_on);
  }

  if (contrast_btn) {
    contrast_btn.setAttribute("aria-pressed", String(contrast_on));
    contrast_btn.classList.toggle("is-active", contrast_on);
  }
}

function add_accessibility_controls() {
  var tools = document.querySelector(".quarto-navbar-tools.tools-wide");
  if (!tools || document.getElementById("toggle-dyslexic-font")) {
    apply_accessibility_preferences();
    return;
  }

  var dyslexic_btn = document.createElement("button");
  dyslexic_btn.id = "toggle-dyslexic-font";
  dyslexic_btn.type = "button";
  dyslexic_btn.className = "quarto-navigation-tool a11y-toggle px-1";
  dyslexic_btn.title = "Toggle dyslexic font";
  dyslexic_btn.setAttribute("aria-label", "Toggle dyslexic font");
  dyslexic_btn.innerHTML = "<i class=\"bi bi-universal-access-circle\" aria-hidden=\"true\"></i>";
  dyslexic_btn.addEventListener("click", function () {
    var current = localStorage.getItem("si-dyslexic-font") === "true";
    localStorage.setItem("si-dyslexic-font", String(!current));
    apply_accessibility_preferences();
  });

  var contrast_btn = document.createElement("button");
  contrast_btn.id = "toggle-high-contrast";
  contrast_btn.type = "button";
  contrast_btn.className = "quarto-navigation-tool a11y-toggle px-1";
  contrast_btn.title = "Toggle high contrast";
  contrast_btn.setAttribute("aria-label", "Toggle high contrast");
  contrast_btn.innerHTML = "<i class=\"bi bi-circle-half\" aria-hidden=\"true\"></i>";
  contrast_btn.addEventListener("click", function () {
    var current = localStorage.getItem("si-high-contrast") === "true";
    localStorage.setItem("si-high-contrast", String(!current));
    apply_accessibility_preferences();
  });

  tools.insertBefore(contrast_btn, tools.firstChild);
  tools.insertBefore(dyslexic_btn, tools.firstChild);
  apply_accessibility_preferences();
}

add_accessibility_controls();
</script>