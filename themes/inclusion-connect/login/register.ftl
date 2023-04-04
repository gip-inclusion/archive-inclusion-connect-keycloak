<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <div id="create-header">
            <h1 class="fr-h4">Créer un compte</h1>
            <p class="fr-text--md fr-mb-3w">Inclusion Connect vous permettra d’utiliser le même identifiant et mot de passe pour plusieurs services, en toute sécurité.</p>
        </div>
        <div id="activate-header" style="display: none">
            <div class="fr-col-lg-7 fr-mb-4w">
                <img src="${url.resourcesPath}/img/logo-inclusion-connect.svg" class="fr-responsive-img" alt="">
            </div>
            <h1 class="fr-h4">Renseignez votre mot de passe</h1>
            <p class="fr-text--md fr-mb-3w">Vous pouvez réutiliser celui de votre compte les emplois de l’inclusion <strong>s'il répond aux critères de sécurité</strong></p>
            <hr class=fr-mt-2w>
        </div>
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
            <div class="fr-text--lg fr-mb-3w" id="activation-description" style="display:none;"></div>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                <input type="text" id="lastName" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('lastName',properties.kcInputErrorClass!)}" name="lastName" value="${(register.formData.lastName!'')}" />
            </div>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                <input type="text" id="firstName" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('firstName',properties.kcInputErrorClass!)}" name="firstName" value="${(register.formData.firstName!'')}" />
            </div>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <label for="email" class="${properties.kcLabelClass!}">
                    ${msg("email")}
                    <span class="fr-hint-text">Format attendu : nom@domaine.fr</span>
                </label>
                <input type="text" id="email" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('email',properties.kcInputErrorClass!)}" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                    <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                    <input type="text" id="username" class="${properties.kcInputClass!} ${messagesPerField.printIfExists('username',properties.kcInputErrorClass!)}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </#if>
            <#if passwordRequired??>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="fr-grid-row">
                        <div class="fr-col">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                        </div>
                        <div class="fr-col-auto">
                            <span class="fr-link ic-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password')" id="show-password">Afficher</span>
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
                            <span class="fr-link ic-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password-confirm')" id="show-password-confirm">Afficher</span>
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
                        <input id="subscribe-btn" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" type="submit" value="S’inscrire" />
                    </li>
                </ul>
            </div>
        </form>
    <#elseif section = "info" >
        <hr class="fr-mt-2w">
        <p class="fr-text fr-mb-1w ic-text-center">
            <span>Vous avez déjà un compte ?</span>
            <a href="${url.loginUrl}" class="fr-link"><strong>Connectez-vous</strong></a>
        </p>
    </#if>
</@layout.registrationLayout>
<script>
    var sp = new URLSearchParams(window.location.search);
    var firstName = sp.get('firstname');
    var firstNameEl = document.getElementById("firstName")
    if (firstName) {
        firstNameEl.value = firstName;
        firstNameEl.readOnly = true;
    }

    var lastName = sp.get('lastname');
    var lastNameEl = document.getElementById("lastName")
    if (lastName) {
        lastNameEl.value = lastName;
        lastNameEl.readOnly = true;
    }

    var emailEl = document.getElementById("email")
    if (emailEl.value) {
        emailEl.readOnly = true;
    }

    if (firstName && lastName && emailEl.value) {
        var createHeader = document.getElementById("create-header");
        createHeader.style.display = 'none'

        var activateHeader = document.getElementById("activate-header");
        activateHeader.style.display = 'block'

        var subscribe = document.getElementById("subscribe-btn");
        subscribe.value = "Activer Inclusion Connect"

        var accountDescriptionEl = document.getElementById("activation-description");
        firstNameEl.parentNode.style.display = 'none';
        lastNameEl.parentNode.style.display = 'none';
        emailEl.parentNode.style.display = 'none';
        accountDescriptionEl.style.display = 'block';
        accountDescriptionEl.innerHTML = lastName + " " + firstName + " (" + emailEl.value + ")"
    }
</script>
