<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script>

/* update total correct if #webex-total_correct exists */
update_total_correct = function() {
  console.log("webex: update total_correct");

  var t = document.getElementsByClassName("webex-total_correct");
  for (var i = 0; i < t.length; i++) {
    p = t[i].parentElement;
    var correct = p.getElementsByClassName("webex-correct").length;
    var solvemes = p.getElementsByClassName("webex-solveme").length;
    var radiogroups = p.getElementsByClassName("webex-radiogroup").length;
    var selects = p.getElementsByClassName("webex-select").length;

    t[i].innerHTML = correct + " of " + (solvemes + radiogroups + selects) + " correct";
  }
}

/* webex-solution button toggling function */
b_func = function() {
  console.log("webex: toggle hide");

  var cl = this.parentElement.classList;
  if (cl.contains('open')) {
    cl.remove("open");
  } else {
    cl.add("open");
  }
}

/* check answers */
check_func = function() {
  console.log("webex: check answers");

  var cl = this.parentElement.classList;
  if (cl.contains('unchecked')) {
    cl.remove("unchecked");
    this.innerHTML = "Hide Answers";
  } else {
    cl.add("unchecked");
    this.innerHTML = "Show Answers";
  }
}

/* function for checking solveme answers */
solveme_func = function(e) {
  console.log("webex: check solveme");

  var real_answers = JSON.parse(this.dataset.answer);
  var my_answer = this.value;
  var cl = this.classList;
  if (cl.contains("ignorecase")) {
    my_answer = my_answer.toLowerCase();
  }
  if (cl.contains("nospaces")) {
    my_answer = my_answer.replace(/ /g, "")
  }

  if (my_answer == "") {
    cl.remove("webex-correct");
    cl.remove("webex-incorrect");
  } else if (real_answers.includes(my_answer)) {
    cl.add("webex-correct");
    cl.remove("webex-incorrect");
  } else {
    cl.add("webex-incorrect");
    cl.remove("webex-correct");
  }

  // match numeric answers within a specified tolerance
  if(this.dataset.tol > 0){
    var tol = JSON.parse(this.dataset.tol);
    var matches = real_answers.map(x => Math.abs(x - my_answer) < tol)
    if (matches.reduce((a, b) => a + b, 0) > 0) {
      cl.add("webex-correct");
    } else {
      cl.remove("webex-correct");
    }
  }

  // added regex bit
  if (cl.contains("regex")){
    answer_regex = RegExp(real_answers.join("|"))
    if (answer_regex.test(my_answer)) {
      cl.add("webex-correct");
    }
  }

  update_total_correct();
}

/* function for checking select answers */
select_func = function(e) {
  console.log("webex: check select");

  var cl = this.classList

  /* add style */
  cl.remove("webex-incorrect");
  cl.remove("webex-correct");
  if (this.value == "answer") {
    cl.add("webex-correct");
  } else if (this.value != "blank") {
    cl.add("webex-incorrect");
  }

  update_total_correct();
}

/* function for checking radiogroups answers */
radiogroups_func = function(e) {
  console.log("webex: check radiogroups");

  var checked_button = document.querySelector('input[name=' + this.id + ']:checked');
  var cl = checked_button.parentElement.classList;
  var labels = checked_button.parentElement.parentElement.children;

  /* get rid of styles */
  for (i = 0; i < labels.length; i++) {
    labels[i].classList.remove("webex-incorrect");
    labels[i].classList.remove("webex-correct");
  }

  /* add style */
  if (checked_button.value == "answer") {
    cl.add("webex-correct");
  } else {
    cl.add("webex-incorrect");
  }

  update_total_correct();
}

window.onload = function() {
  console.log("webex onload");
  /* set up solution buttons */
  var buttons = document.getElementsByTagName("button");

  for (var i = 0; i < buttons.length; i++) {
    if (buttons[i].parentElement.classList.contains('webex-solution')) {
      buttons[i].onclick = b_func;
    }
  }

  var check_sections = document.getElementsByClassName("webex-check");
  console.log("check:", check_sections.length);
  for (var i = 0; i < check_sections.length; i++) {
    check_sections[i].classList.add("unchecked");

    let btn = document.createElement("button");
    btn.innerHTML = "Show Answers";
    btn.classList.add("webex-check-button");
    btn.onclick = check_func;
    check_sections[i].appendChild(btn);

    let spn = document.createElement("span");
    spn.classList.add("webex-total_correct");
    check_sections[i].appendChild(spn);
  }

  /* set up webex-solveme inputs */
  var solveme = document.getElementsByClassName("webex-solveme");

  for (var i = 0; i < solveme.length; i++) {
    /* make sure input boxes don't auto-anything */
    solveme[i].setAttribute("autocomplete","off");
    solveme[i].setAttribute("autocorrect", "off");
    solveme[i].setAttribute("autocapitalize", "off");
    solveme[i].setAttribute("spellcheck", "false");
    solveme[i].value = "";

    /* adjust answer for ignorecase or nospaces */
    var cl = solveme[i].classList;
    var real_answer = solveme[i].dataset.answer;
    if (cl.contains("ignorecase")) {
      real_answer = real_answer.toLowerCase();
    }
    if (cl.contains("nospaces")) {
      real_answer = real_answer.replace(/ /g, "");
    }
    solveme[i].dataset.answer = real_answer;

    /* attach checking function */
    solveme[i].onkeyup = solveme_func;
    solveme[i].onchange = solveme_func;

    $(solveme[i]).after(" <span class='webex-icon'></span>");
  }

  /* set up radiogroups */
  var radiogroups = document.getElementsByClassName("webex-radiogroup");
  for (var i = 0; i < radiogroups.length; i++) {
    radiogroups[i].onchange = radiogroups_func;
  }

  /* set up selects */
  var selects = document.getElementsByClassName("webex-select");
  for (var i = 0; i < selects.length; i++) {
    selects[i].onchange = select_func;
    $(selects[i]).after(" <span class='webex-icon'></span>");
  }

  update_total_correct();
}

</script>
