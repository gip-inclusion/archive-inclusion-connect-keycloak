<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <img src="${url.resourcesPath}/img/logo-inclusion.png">
        <img id="img-from" src="">
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>
            
            <div id="password-state">
                <span>Créer un mot de passe avec au moins:</span>
                <img id="length-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="length-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>8 caractères minimum</span>
                <img id="number-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="number-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 chiffre</span>
                <img id="capital-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="capital-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 majuscule</span>
                <img id="character-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="character-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 caractère spécial (ex: & é @ -)</span>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input onKeyPress="passwordCheck('password-new')" onKeyUp="passwordCheck('password-new')" type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}" autofocus autocomplete="new-password" /><img onclick="showPassword('password-new')" id="show-password" height="25" src="${url.resourcesPath}/img/hide.png">
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" name="password-confirm" class="${properties.kcInputClass!}" autocomplete="new-password" /><img onclick="showPassword('password-confirm')" id="show-password-confirm" height="25" src="${url.resourcesPath}/img/hide.png">
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                    <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                    </#if>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
<script>
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == 'from') 
        {
            
            if (sParameterName[1] == 'dora') {
                document.getElementById("img-from").src="https://i.goopics.net/mtn3xo.png";
            } else if (sParameterName[1] == 'communaute') {
                document.getElementById("img-from").src="https://i.goopics.net/5w86fe.png";
            } else if (sParameterName[1] == 'emplois') {
                document.getElementById("img-from").src="https://i.goopics.net/fyzv6q.png";
            } else {
                document.getElementById("img-from").src="";
            }
        }
    }
</script>
