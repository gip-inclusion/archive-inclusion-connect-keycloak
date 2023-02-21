<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("emailVerificationBodyHtml", link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))?no_esc}
</@layout.emailLayout>
