<#ftl output_format="plainText">
${msg("greeting")}
${msg("emailUpdateConfirmationBody",link, newEmail, realmName, linkExpirationFormatter(linkExpiration))}
${msg("closing")}
