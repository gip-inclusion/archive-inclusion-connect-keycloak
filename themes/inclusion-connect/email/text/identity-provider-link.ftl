<#ftl output_format="plainText">
${msg("greeting")}
${msg("identityProviderLinkBody", identityProviderDisplayName, realmName, identityProviderContext.username, link, linkExpiration, linkExpirationFormatter(linkExpiration))}
${msg("closing")}