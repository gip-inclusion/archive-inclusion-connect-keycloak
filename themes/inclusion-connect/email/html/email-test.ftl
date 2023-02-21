<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("emailTestBodyHtml",realmName)?no_esc}
</@layout.emailLayout>
