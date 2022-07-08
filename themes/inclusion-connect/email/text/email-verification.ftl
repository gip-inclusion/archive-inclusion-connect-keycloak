<#ftl output_format="plainText">
${msg("greeting")}
${msg("emailVerificationBody",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))}
${msg("closing")}