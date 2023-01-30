<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <h1 class="fr-h4">Mot de passe</h1>
        <p class="fr-text--md fr-mb-3w">Entrez votre nouveau mot de passe.</p>
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                    <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;" />

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
                        <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;" />
                        <input onKeyPress="passwordCheck('password-new')" onKeyUp="passwordCheck('password-new')" type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}" autofocus autocomplete="new-password" />
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

                    <div class="${properties.kcFormGroupClass!}">
                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                            <div class="${properties.kcFormOptionsWrapperClass!}"></div>
                        </div>

                        <div id="kc-form-buttons">
                            <#if isAppInitiatedAction??>
                                <ul class="fr-btns-group">
                                    <li>
                                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                    </li>
                                    <li>
                                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                                    </li>
                                </ul>
                            <#else>
                                <ul class="fr-btns-group">
                                    <li>
                                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                    </li>
                                </ul>
                            </#if>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
