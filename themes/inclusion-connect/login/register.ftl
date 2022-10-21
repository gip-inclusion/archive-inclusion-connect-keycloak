<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <p class="fr-h5 fr-mb-0 service-from"></p>
        <h1 class="fr-h1">Créer un compte</h1>
        <p class="fr-text--lg fr-mb-3w">Créer un compte Inclusion Connect vous permettra d'utiliser le même identifiant et le même mot de passe pour plusieurs services.</p>
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                <input type="text" id="lastName" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('lastName',properties.kcInputErrorClass!)}" name="lastName" value="${(register.formData.lastName!'')}" />
            </div>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                <input type="text" id="firstName" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('firstName',properties.kcInputErrorClass!)}" name="firstName" value="${(register.formData.firstName!'')}" />
            </div>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                <input type="text" id="email" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('email',properties.kcInputErrorClass!)}" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                    <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                    <input type="text" id="username" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </#if>
            <#if passwordRequired??>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="fr-grid-row">
                        <div class="fr-col">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                        </div>
                        <div class="fr-col-auto">
                            <span class="fr-link fr-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password')" id="show-password">Afficher</span>
                        </div>
                    </div>
                    <div class="fr-hint-text fr-mt-2v">
                        <ul>
                            <li><span class="fr-icon-error-line fr-icon--sm" aria-hidden="true" id="length-criteria-1"></span><span class="fr-text-default--success fr-icon-success-line fr-icon--sm" aria-hidden="true" id="length-criteria"></span> 8 caractères minimum</li>
                            <li><span class="fr-icon-error-line fr-icon--sm" aria-hidden="true" id="number-criteria-1"></span><span class="fr-text-default--success fr-icon-success-line fr-icon--sm" aria-hidden="true" id="number-criteria"></span> 1 chiffre</li>
                            <li><span class="fr-icon-error-line fr-icon--sm" aria-hidden="true" id="capital-criteria-1"></span><span class="fr-text-default--success fr-icon-success-line fr-icon--sm" aria-hidden="true" id="capital-criteria"></span> 1 majuscule</li>
                            <li><span class="fr-icon-error-line fr-icon--sm" aria-hidden="true" id="character-criteria-1"></span><span class="fr-text-default--success fr-icon-success-line fr-icon--sm" aria-hidden="true" id="character-criteria"></span> 1 caractère spécial (ex: & é @ -)</li>
                        </ul>
                    </div>
                    <input onKeyPress="passwordCheck('password')" onKeyUp="passwordCheck('password')" type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password">
                </div>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                    <div class="fr-grid-row">
                        <div class="fr-col">
                            <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                        </div>
                        <div class="fr-col-auto">
                            <span class="fr-link fr-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password-confirm')" id="show-password-confirm">Afficher</span>
                        </div>
                    </div>
                    <input type="password" id="password-confirm" class="${properties.kcInputClass!} fr-mt-2v" name="password-confirm" />
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </#if>
            <div id="kc-form-buttons">
                <ul class="fr-btns-group">
                    <li>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" type="submit" value="${msg("doRegister")}"/>
                    </li>
                </ul>
            </div>
        </form>
    <#elseif section = "info" >
        <p class="fr-mt-3w">
            <a href="${url.loginUrl}" class="fr-link">${kcSanitize(msg("backToLogin"))?no_esc}</a>
        </p>
    </#if>
</@layout.registrationLayout>
