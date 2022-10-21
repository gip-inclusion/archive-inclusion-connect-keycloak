<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <p class="fr-h5 fr-mb-0 service-from"></p>
        <h1 class="fr-h1">Déconnexion</h1>
        <p class="fr-text--lg fr-mb-3w">${msg("logoutConfirmHeader")}</p>
    <#elseif section = "form">
        <div id="kc-logout-confirm">
            <form class="form-actions" action="${url.logoutConfirmAction}" method="POST">
                <div id="kc-form-buttons">
                    <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                    <ul class="fr-btns-group">
                        <li>
                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="confirmLogout" id="kc-logout" type="submit" value="${msg("doLogout")}"/>
                        </li>
                    </ul>
                </div>
            </form>
        </div>
    <#elseif section = "info" >
        <#if logoutConfirm.skipLink>
        <#else>
            <#if (client.baseUrl)?has_content>
                <p class="fr-mt-3w">
                    <a href="${client.baseUrl}" class="fr-link">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                </p>
            </#if>
        </#if>
    </#if>
</@layout.registrationLayout>
