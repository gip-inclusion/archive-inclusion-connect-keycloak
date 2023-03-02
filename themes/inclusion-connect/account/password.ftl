<#import "template.ftl" as layout>
<@layout.mainLayout active='password' bodyClass='password'; section>
    <#if section = "header">
        <h1 class="fr-h4">${msg("changePasswordHtmlTitle")}</h1>
    <#elseif section = "content">

        <form action="${url.passwordUrl}" class="form-horizontal" method="post">
            <input type="text" id="username" name="username" value="${(account.username!'')}" autocomplete="username" readonly="readonly" style="display:none;">

            <#if password.passwordSet>
                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="fr-label">Mot de passe actuel</label>
                    <input type="password" class="fr-input" id="password" name="password" autofocus autocomplete="current-password">
                </div>
            </#if>

            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <div class="${properties.kcFormGroupClass!}">
                <div class="fr-grid-row">
                    <div class="fr-col">
                        <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                    </div>
                    <div class="fr-col-auto">
                        <span class="fr-link ic-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password-new')" id="show-password-new">Afficher</span>
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
                <input onKeyPress="passwordCheck('password-new')" onKeyUp="passwordCheck('password-new')" type="password" id="password-new" class="fr-input fr-mt-2v" name="password-new" autocomplete="new-password">
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="fr-grid-row">
                    <div class="fr-col">
                        <label for="password-confirm" class="fr-label">${msg("passwordConfirm")}</label>
                    </div>
                    <div class="fr-col-auto">
                        <span class="fr-link ic-text-underline fr-icon-eye-line fr-link--icon-left" onclick="showPassword('password-confirm')" id="show-password-confirm">Afficher</span>
                    </div>
                </div>
                <input type="password" id="password-confirm" class="fr-input fr-mt-2v" name="password-confirm" />
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-buttons" class="submit">
                    <ul class="fr-btns-group">
                        <li>
                            <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Save">${msg("doSavePassword")}</button>
                        </li>
                        <li>
                            <a class="fr-btn fr-btn--tertiary" <#if referrer?has_content && referrer.url?has_content>href="${referrer.url}"</#if> id="referrer" disabled>${msg("backToApplication")}</a>
                        </li>
                    </ul>
                </div>
            </div>
        </form>
    </#if>
</@layout.mainLayout>
