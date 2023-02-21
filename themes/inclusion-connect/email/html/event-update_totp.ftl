<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("eventUpdateTotpBodyHtml",event.date, event.ipAddress)?no_esc}
</@layout.emailLayout>
