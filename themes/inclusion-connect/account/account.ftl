<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>
    <#if section = "header">
        <h1 class="fr-h4">${msg("editAccountHtmlTitle")}</h1>
    <#elseif section = "content">
        <form action="${url.accountUrl}" class="form-horizontal" method="post">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                    <label for="username" class="fr-label">${msg("username")}</label>
                    <input type="text" class="fr-input ${messagesPerField.printIfExists('username',properties.kcInputErrorClass!)}" id="username" name="username" <#if !realm.editUsernameAllowed>disabled="disabled"</#if> value="${(account.username!'')}"/>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <label for="lastName" class="fr-label">${msg("lastName")}</label>
                <input type="text" class="fr-input ${messagesPerField.printIfExists('lastName',properties.kcInputErrorClass!)}" id="lastName" name="lastName" value="${(account.lastName!'')}"/>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <label for="firstName" class="fr-label">${msg("firstName")}</label>
                <input type="text" class="fr-input ${messagesPerField.printIfExists('firstName',properties.kcInputErrorClass!)}" id="firstName" name="firstName" value="${(account.firstName!'')}"/>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <label for="email" class="fr-label">
                    ${msg("email")}
                    <span class="fr-hint-text">Format attendu : nom@domaine.fr</span>
                </label>
                <input type="text" class="fr-input ${messagesPerField.printIfExists('email',properties.kcInputErrorClass!)}" id="email" name="email" autofocus value="${(account.email!'')}"/>
            </div>

            <div class="fr-alert fr-alert--warning fr-mb-3w">
                Êtes-vous sûr.e d’avoir correctement renseigné votre nouvelle adresse e-mail ? Quand vous aurez terminé, vous recevrez un e-mail de vérification à cette adresse, étape obligatoire pour ne pas bloquer votre compte.
            </div>

            <div id="kc-form-buttons" class="submit">
                <ul class="fr-btns-group">
                    <li>
                        <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Save">${msg("doSave")}</button>
                    </li>
                    <li>
                        <a class="fr-btn fr-btn--tertiary" <#if referrer?has_content && referrer.url?has_content>href="${referrer.url}"</#if> id="referrer" disabled>${msg("backToApplication")}</a>
                    </li>
                </ul>
            </div>

        </form>
    </#if>
</@layout.mainLayout>
