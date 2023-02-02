<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "header">
        <h1 class="fr-h4">${msg("doLogIn")}</h1>
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                            <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if><span class="fr-hint-text">Format attendu : nom@domaine.fr</span></label>
                            <#if usernameEditDisabled??>
                                <input tabindex="1" id="username" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('username',properties.kcInputErrorClass!)}" name="username" value="${(login.username!'')}" type="text" disabled />
                            <#else>
                                <input tabindex="1" id="username" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('username',properties.kcInputErrorClass!)}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" />
                            </#if>
                        </div>
                        <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password',properties.kcFormGroupErrorClass!)}">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                            <input tabindex="2" id="password" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('password',properties.kcInputErrorClass!)}" name="password" type="password" autocomplete="off" />
                            <#if realm.resetPasswordAllowed>
                                <p class="fr-mt-1w">
                                    <a href="${url.loginResetCredentialsUrl}" tabindex="5" class="fr-link">${msg("doForgotPassword")}</a>
                                </p>
                            </#if>
                        </div>
                        <div id="kc-form-options" class="${properties.kcFormGroupClass!}">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="fr-checkbox-group">
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked>
                                        <label class="fr-label" for="rememberMe">${msg("rememberMe")}</label>
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                                        <label class="fr-label" for="rememberMe">${msg("rememberMe")}</label>
                                    </#if>
                                </div>
                            </#if>
                        </div>
                        <div id="kc-form-buttons">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <ul class="fr-btns-group">
                                <li>
                                    <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                                </li>
                            </ul>
                        </div>
                    </form>
                </#if>
            </div>

            <#if realm.password && social.providers??>
                <hr class="fr-mt-3w">
                <div id="kc-social-providers" class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}">
                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 4>${properties.kcFormSocialAccountDoubleListClass!}</#if>">
                        <#list social.providers as p>
                            <li class="${properties.kcFormSocialAccountListLinkClass!}"><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span>${p.displayName}</span></a></li>
                        </#list>
                    </ul>
                </div>
            </#if>
        </div>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <hr class="fr-mt-2w">
            <p class="fr-text fr-mb-1w ic-text-center"><strong>Vous n’avez pas de compte Inclusion Connect ?</strong></p>
            <ul class="fr-btns-group ic-text-center">
                <li>
                    <a class="fr-link" href="${url.registrationUrl}"><strong>${msg("doRegister")}</strong></a>
                </li>
            </ul>
        </#if>
    </#if>
</@layout.registrationLayout>
