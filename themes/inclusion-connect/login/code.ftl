<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <p class="fr-h5 fr-mb-0 service-from"></p>
        <h1 class="fr-h1">
            <#if code.success>
                ${msg("codeSuccessTitle")}
            <#else>
                ${msg("codeErrorTitle", code.error)}
            </#if>
        </h1>
        <p class="fr-text--lg fr-mb-3w">${msg("copyCodeInstruction")}</p>
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
            <p class="fr-mt-3w">
                <a id="backToApplication" class="fr-link" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
            </p>
        </#if>
    </#if>
</@layout.registrationLayout>
