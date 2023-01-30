<#import "template.ftl" as layout>
<@layout.registrationLayout displayForm=false; section>
    <#if section = "header">
        <h1 class="fr-h4">Regardez votre boite mail !</h1>
        <p class="fr-text--md fr-mb-3w">
            ${msg("emailVerifyInstruction1")}
        </p>
        <p class="fr-text fr-mb-3w">
            ${msg("emailVerifyInstruction2")} <a href="${url.loginAction}" class="fr-link"><strong>${msg("doClickHere")}</strong></a> ${msg("emailVerifyInstruction3")}
        </p>
    </#if>
</@layout.registrationLayout>
