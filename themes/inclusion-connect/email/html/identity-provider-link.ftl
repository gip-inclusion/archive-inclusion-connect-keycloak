<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<body>
${msg("greetingHtml")?no_esc}
${msg("identityProviderLinkBodyHtml", identityProviderDisplayName, realmName, identityProviderContext.username, link, linkExpiration, linkExpirationFormatter(linkExpiration))?no_esc}
${msg("closingHtml")?no_esc}
</body>
</html>