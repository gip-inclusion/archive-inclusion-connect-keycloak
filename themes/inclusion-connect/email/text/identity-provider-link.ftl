<#ftl output_format="plainText">
${msg("greeting")}
${msg("identityProviderLinkBody", identityProviderAlias, realmName, identityProviderContext.username, link, linkExpiration, linkExpirationFormatter(linkExpiration))}
${msg("closing")}