function setService(el) {
    var sp = new URLSearchParams(window.location.search);
    var from = sp.get('from');
    if (from) {
      localStorage.setItem("from", params["from"]);
    }

    var service = document.getElementsByClassName("service-from");
    var from = localStorage.getItem("from");
    var name;

    switch (from) {
        case 'dora':
            name = "Dora";
        break;
        case 'communaute':
            name = "La communauté de l'inclusion";
        break;
        case 'emplois':
            name = "Les emplois de l'inclusion";
        break;
        case 'cnfs':
            name = "Conseiller Numérique";
            break;
        default:
            name = "";
    }

    Array.prototype.forEach.call(service, function(el) {
        el.innerHTML = name;
    });
}
