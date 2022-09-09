<html>
<body>
${msg("greetingHtml")?no_esc}
${msg("passwordResetBodyHtml",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))?no_esc}
${msg("closingHtml")?no_esc}
</body>
</html>