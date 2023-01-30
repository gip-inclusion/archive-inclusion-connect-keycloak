<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <h1 class="fr-h4">Déconnexion</h1>
        <p class="fr-text--md fr-mb-3w">${msg("logoutConfirmHeader")}</p>
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
        <hr class="fr-mt-2w">
        <#if logoutConfirm.skipLink>
        <#else>
            <#if (client.baseUrl)?has_content>
                <ul class="fr-btns-group ic-text-center">
                    <li>
                        <a href="${client.baseUrl}" class="fr-link"><strong>${kcSanitize(msg("backToApplication"))?no_esc}</strong></a>
                    </li>
                </ul>
            </#if>
        </#if>
    </#if>
</@layout.registrationLayout>
