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
  if (document.getElementById(element).type == "password") {
    document.getElementById(element).type = "text";
    document.getElementById("show-" + element).className = "fr-link ic-text-underline fr-icon-eye-off-line fr-link--icon-left";
    document.getElementById("show-" + element).innerHTML = "Masquer";
  } else {
    document.getElementById(element).type = "password";
    document.getElementById("show-" + element).className = "fr-link ic-text-underline fr-icon-eye-line fr-link--icon-left";
    document.getElementById("show-" + element).innerHTML = "Afficher";
  }
}

// Fix "email already exists" error messages that also contains twice the usernameExistsMessage message bellow emailExistsMessage...
window.addEventListener("load", () => {
  var alerts = document.getElementsByClassName("fr-alert")
  if (alerts != []) {
    Array.prototype.forEach.call(alerts, function(alert) {
      if (alert.innerHTML.includes("Cette adresse e-mail existe déjà sur Inclusion Connect, vous ne pouvez pas l’utiliser")) {
        alert.innerHTML = "Cette adresse e-mail existe déjà sur Inclusion Connect, vous ne pouvez pas l’utiliser"
      } 
    })
  }
})

// vim: sw=2 et ts=2 sts=2
