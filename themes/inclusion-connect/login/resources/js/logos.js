function setLogo(element) {
    var sp = new URLSearchParams(window.location.search);
    var from = sp.get('from')
    if (from) {
      localStorage.setItem("from", params["from"])
    }

    var img = document.getElementById("img-from")
    var from = localStorage.getItem("from");
    switch (from) {
        case 'dora':
            img.src = "https://i.goopics.net/pnj9ji.png";
            break;
        case 'communaute':
            img.src = "https://i.goopics.net/5w86fe.png";
            break;
        case 'emplois':
            img.src = "https://i.goopics.net/fyzv6q.png";
            break;
        case 'cnfs':
            img.src = "https://i.goopics.net/38rn3p.png";
            break;
        default:
            img.src = "";
    }
}