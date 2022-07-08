<#ftl output_format="plainText">
${msg("greeting")}
${msg("passwordResetBody",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))}
${msg("closing")}