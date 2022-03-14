<html>
<body>
<img src="${url.resourcesPath}/img/logo-inclusion.png">
${kcSanitize(msg("eventUpdatePasswordBodyHtml",event.date, event.ipAddress))?no_esc}
</body>
</html>
