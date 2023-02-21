<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("passwordResetBodyHtml",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))?no_esc}
</@layout.emailLayout>
