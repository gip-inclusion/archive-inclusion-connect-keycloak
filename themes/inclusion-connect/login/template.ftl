<#macro registrationLayout bodyClass="" displayInfo=false displayForm=true displayMessage=true displayRequiredFields=false displayWide=false showAnotherWayIfPresent=true>
<!doctype html>
<html lang="fr" data-fr-scheme="system">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <meta name="theme-color" content="#000091"><!-- Défini la couleur de thème du navigateur (Safari/Android) -->
        <link rel="apple-touch-icon" href="${url.resourcesPath}/../../common/inclusion-connect/apple-touch-icon.png"><!-- 180×180 -->
        <link rel="icon" href="${url.resourcesPath}/../../common/inclusion-connect/img/illustration-bg-ic.svg" type="image/svg+xml">
        <link rel="icon" href="${url.resourcesPath}/../../common/inclusion-connect/img/favicon.ico">
        <link rel="manifest" href="${url.resourcesPath}/favicon/manifest.webmanifest" crossorigin="use-credentials">
        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
    </head>

    <body class="${properties.kcBodyClass!}">
        <div class="fr-skiplinks">
            <nav class="fr-container" role="navigation" aria-label="Accès rapide">
                <ul class="fr-skiplinks__list">
                    <li>
                        <a class="fr-link" href="#contenu">Contenu</a>
                    </li>
                    <li>
                        <a class="fr-link" href="#footer">Pied de page</a>
                    </li>
                </ul>
            </nav>
        </div>
        <header role="banner" class="fr-header">
            <div class="fr-header__body">
                <div class="fr-container">
                    <div class="fr-header__body-row">
                        <div class="fr-header__brand fr-enlarge-link">
                            <div class="fr-header__brand-top">
                                <div class="fr-header__logo">
                                    <p class="fr-logo">
                                    Ministère<br>
                                    du travail,<br>
                                    du plein emploi<br>
                                    et de l'insertion
                                    </p>
                                </div>
                            </div>
                            <div class="fr-header__service">
                                <a href="${url.loginUrl}" class="fr-header__service-title">
                                    Inclusion Connect
                                </a>
                                <p class="fr-header__service-tagline"><strong>Service d'authentification</strong></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <main role="main" id="contenu">

            <div class="fr-container">
                <div class="fr-my-6w fr-my-md-10w fr-grid-row fr-background-alt--grey">
                    <div class="fr-col-12 fr-col-lg-6 fr-p-4w fr-px-md-12w fr-py-md-7w fr-background-default--grey">
                        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                            <#if displayRequiredFields>
                                <#nested "header">
                                <p class="fr-text fr-mb-3w"><span>*</span> ${msg("requiredFields")}</p>
                            <#else>
                                <#nested "header">
                            </#if>
                        <#else>
                            <#if displayRequiredFields>
                                <span class="fr-text fr-mb-3w"><span>*</span> ${msg("requiredFields")}</span>
                                <#nested "show-username">
                                <div class="${properties.kcFormGroupClass!}">
                                    <div id="kc-username">
                                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                            <div class="kc-login-tooltip">
                                                <i class="${properties.kcResetFlowIcon!}"></i>
                                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            <#else>
                                <#nested "show-username">
                                <div class="${properties.kcFormGroupClass!}">
                                    <div id="kc-username">
                                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                            <div class="kc-login-tooltip">
                                                <i class="${properties.kcResetFlowIcon!}"></i>
                                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </#if>
                        </#if>

                        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                        <#-- during login.                                                                               -->
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <div class="fr-alert fr-alert--${message.type} fr-mb-3w">
                                <p>${kcSanitize(message.summary)?no_esc}</p>
                            </div>
                        </#if>
                        <#if displayForm>
                            <#nested "form">

                            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                                <hr class="fr-mt-3w">
                                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" <#if displayWide>class="${properties.kcContentWrapperClass!}"</#if>>
                                    <div class="${properties.kcFormGroupClass!}">
                                        <input type="hidden" name="tryAnotherWay" value="on" />
                                        <a href="#" class="fr-link" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                    </div>
                                </form>
                            </#if>
                        </#if>
                        <#if displayInfo>
                            <div class="fr-mb-3w">
                                <#nested "info">
                            </div>
                        </#if>
                    </div>
                    <div class="fr-hidden ic-block-img-lg fr-col-lg-6 fr-p-4w fr-py-md-7w">
                        <img src="${url.resourcesPath}/../../common/inclusion-connect/img/illustration-ic.svg" class="fr-fluid-img" alt="">
                    </div>
                </div>
            </div>
        </main>

        <footer class="fr-footer fr-pb-4w" id="footer" role="contentinfo">
            <div class="fr-container">
                <div class="fr-footer__body">
                    <div class="fr-footer__brand">
                    <p class="fr-logo">
                        Ministère<br>
                        du travail,<br>
                        du plein emploi<br>
                        et de l'insertion
                    </p>
                    </div>
                    <div class="fr-footer__content">
                        <p class="fr-footer__content-desc">Inclusion Connect est un Single Sign-On (SSO). Autrement dit c'est un service d'authentification qui permet à un utilisateur d'utiliser les mêmes informations d'identification (email et mot de passe) pour accéder à plusieurs applications.</p>
                        <ul class="fr-footer__content-list">
                            <li class="fr-footer__content-item">
                                <a class="fr-footer__content-link" target="_blank" href="https://legifrance.gouv.fr">legifrance.gouv.fr</a>
                            </li>
                            <li class="fr-footer__content-item">
                                <a class="fr-footer__content-link" target="_blank" href="https://gouvernement.fr">gouvernement.fr</a>
                            </li>
                            <li class="fr-footer__content-item">
                                <a class="fr-footer__content-link" target="_blank" href="https://service-public.fr">service-public.fr</a>
                            </li>
                            <li class="fr-footer__content-item">
                                <a class="fr-footer__content-link" target="_blank" href="https://data.gouv.fr">data.gouv.fr</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
</#macro>
