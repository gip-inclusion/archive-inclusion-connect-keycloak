<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayForm=false displayInfo=true; section>
    <#if section = "header">
        <h1 class="fr-h4">Erreur</h1>
        <p class="fr-text--md fr-mb-3w">${message.summary?no_esc}</p>
    <#elseif section = "info">
        <#if client?? && client.baseUrl?has_content>
            <hr class="fr-mt-2w">
            <ul class="fr-btns-group ic-text-center">
                <li>
                    <a id="backToApplication" class="fr-link" href="${client.baseUrl}"><strong>${kcSanitize(msg("backToApplication"))?no_esc}</strong></a>
                </li>
            </ul>
        </#if>
    </#if>
</@layout.registrationLayout>
