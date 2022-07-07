function passwordCheck(element) {
  // check if input is bigger than 3
  var value = document.getElementById(element).value;

  if (value.length >= 8) {
    document.getElementById("length-criteria").style.display = "inline-block";
    document.getElementById("length-criteria-1").style.display = "none";
  } else {
    document.getElementById("length-criteria").style.display = "none";
    document.getElementById("length-criteria-1").style.display = "inline-block";
  }

  if (/\d/.test(value)) {
    document.getElementById("number-criteria").style.display = "inline-block";
    document.getElementById("number-criteria-1").style.display = "none";
  } else {
    document.getElementById("number-criteria").style.display = "none";
    document.getElementById("number-criteria-1").style.display = "inline-block";
  }

  if (/[A-Z]/.test(value)) {
    document.getElementById("capital-criteria").style.display = "inline-block";
    document.getElementById("capital-criteria-1").style.display = "none";
  } else {
    document.getElementById("capital-criteria").style.display = "none";
    document.getElementById("capital-criteria-1").style.display =
      "inline-block";
  }

  if (/[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/.test(value)) {
    document.getElementById("character-criteria").style.display =
      "inline-block";
    document.getElementById("character-criteria-1").style.display = "none";
  } else {
    document.getElementById("character-criteria").style.display = "none";
    document.getElementById("character-criteria-1").style.display =
      "inline-block";
  }
}

function showPassword(element) {
  let src = document.getElementById("show-" + element).src;
  src = src.split("/");
  if (document.getElementById(element).type == "password") {
    document.getElementById(element).type = "text";
    document.getElementById("show-" + element).src =
      "/auth/resources/" + src[5] + "/login/inclusion-connect/img/view.png"; // The src[5] part is used because this bit of the url is random
  } else {
    document.getElementById(element).type = "password";
    document.getElementById("show-" + element).src =
      "/auth/resources/" + src[5] + "/login/inclusion-connect/img/hide.png";
  }
}

function goToRegisterPage() {
  localStorage.setItem("pass", "true");
  var elements = document.getElementsByClassName("pre-register");
  for (var i = 0, len = elements.length; i < len; i++) {
    elements[i].style.display = "none";
  }

  var elements = document.getElementsByClassName("register-form");
  for (var i = 0, len = elements.length; i < len; i++) {
    elements[i].style.display = "block";
  }
}
