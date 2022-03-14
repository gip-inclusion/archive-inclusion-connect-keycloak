<html>
<body>
<img src="${url.resourcesPath}/img/logo-inclusion.png">
${kcSanitize(msg("passwordResetBodyHtml",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration)))?no_esc}
</body>
</html>