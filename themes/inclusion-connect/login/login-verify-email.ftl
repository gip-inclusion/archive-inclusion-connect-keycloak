<#import "template.ftl" as layout>
<@layout.registrationLayout displayForm=false; section>
    <#if section = "header">
        <p class="fr-h5 fr-mb-0 service-from"></p>
        <h1 class="fr-h1">Vérification de votre adresse e-mail</h1>
        <p class="fr-text--lg">
            ${msg("emailVerifyInstruction1")}
        </p>
        <p class="fr-text--lg fr-mb-3w">
            ${msg("emailVerifyInstruction2")} <a href="${url.loginAction}" class="fr-link">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
        </p>
    </#if>
</@layout.registrationLayout>
