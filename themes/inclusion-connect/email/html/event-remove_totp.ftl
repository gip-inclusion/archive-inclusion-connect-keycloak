<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("eventRemoveTotpBodyHtml",event.date, event.ipAddress)?no_esc}
</@layout.emailLayout>
