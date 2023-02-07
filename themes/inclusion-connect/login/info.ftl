<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
            <p class="fr-text--md fr-mb-3w">${messageHeader}</p>
        </#if>
    <#elseif section = "form">
    <div id="kc-info-message">
        <p class="fr-text--md instruction">${message.summary}<#if requiredActions??><#list requiredActions>: <b><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#items></b></#list><#else></#if></p>
        <#if skipLink??>
        <#else>
            <#if pageRedirectUri?has_content>
                <hr class="fr-mt-2w">
                <p><a href="${pageRedirectUri}" class="fr-link"><strong>${kcSanitize(msg("backToApplication"))?no_esc}</strong></a></p>
            <#elseif actionUri?has_content>
                <hr class="fr-mt-2w">
                <p><a href="${actionUri}" class="fr-link"><strong>${kcSanitize(msg("proceedWithAction"))?no_esc}</strong></a></p>
            <#elseif (client.baseUrl)?has_content>
                <hr class="fr-mt-2w">
                <p><a href="${client.baseUrl}" class="fr-link"><strong>${kcSanitize(msg("backToApplication"))?no_esc}</strong></a></p>
            </#if>
        </#if>
    </div>
    </#if>
</@layout.registrationLayout>
