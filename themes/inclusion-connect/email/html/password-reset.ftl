<html>
<body>
${kcSanitize(msg("greetingHtml"))?no_esc}
${kcSanitize(msg("passwordResetBodyHtml",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration)))?no_esc}
${kcSanitize(msg("closingHtml"))?no_esc}
</body>
</html>