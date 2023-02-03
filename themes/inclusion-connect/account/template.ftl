<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title>${msg("accountManagementTitle")}</title>
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
            <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
        </#list>
    </#if>
</head>
<body class="admin-console user ${bodyClass}">
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
                            <span class="fr-header__service-title">
                                Inclusion Connect
                            </span>
                            <p class="fr-header__service-tagline"><strong>Service d'authentification</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main role="main" id="contenu">
        <div class="fr-container">
            <div class="fr-my-6w fr-my-md-10w fr-grid-row fr-background-default--grey">
                <div class="fr-col-12 fr-col-lg-6 fr-p-4w fr-p-md-7w">
                    <nav class="fr-sidemenu" aria-labelledby="fr-sidemenu-title">
                        <div class="fr-sidemenu__inner">
                            <button class="fr-sidemenu__btn" aria-controls="fr-sidemenu-wrapper" aria-expanded="false" data-fr-js-collapse-button="true" hidden="">
                                Mon compte
                            </button>
                            <div class="fr-collapse" id="fr-sidemenu-wrapper" data-fr-js-collapse="true">
                                <div class="fr-sidemenu__title" id="fr-sidemenu-title">Mon compte</div>
                                <ul class="fr-sidemenu__list" data-fr-js-sidemenu-list="true">
                                    <li class="fr-sidemenu__item<#if active=='account'> fr-sidemenu__item--active</#if>"><a href="${url.accountUrl}" class="fr-sidemenu__link" <#if active=='account'>aria-current="page"</#if>>${msg("editAccountHtmlTitle")}</a></li>
                                    <#if features.passwordUpdateSupported><li class="fr-sidemenu__item<#if active=='password'> fr-sidemenu__item--active</#if>"><a href="${url.passwordUrl}" class="fr-sidemenu__link" <#if active=='password'>aria-current="page"</#if>>${msg("password")}</a></li></#if>
                                    <#-- <li class="fr-sidemenu__item<#if active=='totp'> fr-sidemenu__item--active</#if>"><a href="${url.totpUrl}" class="fr-sidemenu__link" <#if active=='totp'>aria-current="page"</#if>>${msg("authenticator")}</a></li> -->
                                    <#if features.identityFederation><li class="fr-sidemenu__item<#if active=='social'> fr-sidemenu__item--active</#if>"><a href="${url.socialUrl}" class="fr-sidemenu__link" <#if active=='social'>aria-current="page"</#if>>${msg("federatedIdentity")}</a></li></#if>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="fr-col-12 fr-col-lg-6 fr-p-4w fr-px-md-12w fr-py-md-7w">
                    <#nested "header">

                    <#if message?has_content>
                        <div class="fr-alert fr-alert--${message.type} fr-mb-3w">
                            <p>${kcSanitize(message.summary)?no_esc}</p>
                        </div>
                    </#if>

                    <#nested "content">
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
