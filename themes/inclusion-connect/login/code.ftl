<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <h1 class="fr-h4">
            <#if code.success>
                ${msg("codeSuccessTitle")}
            <#else>
                ${msg("codeErrorTitle", code.error)}
            </#if>
        </h1>
        <p class="fr-text--md fr-mb-3w">${msg("copyCodeInstruction")}</p>
    <#elseif section = "form">
        <div id="kc-code">
            <#if code.success>
                <div class="${properties.kcFormGroupClass!}">
                    <input id="code" class="${properties.kcTextareaClass!}" value="${code.code}"/>
                </div>
            <#else>
                <p id="error">${code.error}</p>
            </#if>
        </div>
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
