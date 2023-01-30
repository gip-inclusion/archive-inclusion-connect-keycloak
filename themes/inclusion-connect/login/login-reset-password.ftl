<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <h1 class="fr-h4">${msg("doForgotPassword")}</h1>
        <p class="fr-text--md fr-mb-3w">${msg("emailInstruction")}</p>
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <#if auth?has_content && auth.showUsername()>
                    <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${auth.attemptedUsername}"/>
                <#else>
                    <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus/>
                </#if>
            </div>
            <div id="kc-form-buttons">
                <ul class="fr-btns-group">
                    <li>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" type="submit" value="${msg("doSubmit")}"/>
                    </li>
                </ul>
            </div>
        </form>
    <#elseif section = "info" >
        <hr class="fr-mt-2w">
        <ul class="fr-btns-group ic-text-center">
            <li>
                <a href="${url.loginUrl}" class="fr-link"><strong>${kcSanitize(msg("backToLogin"))?no_esc}</strong></a>
            </li>
        </ul>
    </#if>
</@layout.registrationLayout>
<script>
    var sp = new URLSearchParams(window.location.search);
    var email = sp.get('email');
    if (email) {
        document.getElementById("username").value = email;
    }
</script>
