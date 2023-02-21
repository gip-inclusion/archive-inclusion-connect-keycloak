<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("eventUpdatePasswordBodyHtml",event.date, event.ipAddress)?no_esc}
</@layout.emailLayout>
