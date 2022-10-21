<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayForm=false displayInfo=true; section>
    <#if section = "header">
        <p class="fr-h5 fr-mb-0 service-from"></p>
        <h1 class="fr-h1">Erreur</h1>
        <p class="fr-text--lg fr-mb-3w">${message.summary?no_esc}</p>
    <#elseif section = "info">
        <#if client?? && client.baseUrl?has_content>
            <p class="fr-mt-3w">
                <a id="backToApplication" class="fr-link" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
            </p>
        </#if>
    </#if>
</@layout.registrationLayout>
