<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <h1 class="fr-h4">Conditions d’utilisation et confidentialité</h1>
    <#elseif section = "form">
    <div id="kc-terms-text">
        <p>
        Pour utiliser votre compte Inclusion Connect, vous devez accepter les conditions générales d’utilisation du service ainsi que la politique de confidentialité.
        </p>
        <ul class="fr-mb-3w">
            <li>
                <a href="${url.resourcesPath}/../../common/inclusion-connect/terms/CGU_V3.pdf" target="_blank">
                    Conditions générales d’utilisation
                </a>
            </li>
            <li>
                <a href="${url.resourcesPath}/../../common/inclusion-connect/terms/Politique de confidentialité_V2.pdf" target="_blank">
                    Politique de confidentialité
                </a>
            </li>
        </ul>
    </div>
    <form class="form-actions" action="${url.loginAction}" method="POST">
        <ul class="fr-btns-group">
            <li>
                <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
            </li>
        </ul>
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
