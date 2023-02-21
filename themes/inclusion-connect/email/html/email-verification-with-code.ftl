<#import "template.ftl" as layout>
<@layout.emailLayout>
${msg("emailVerificationBodyCodeHtml",code)?no_esc}
</@layout.emailLayout>
