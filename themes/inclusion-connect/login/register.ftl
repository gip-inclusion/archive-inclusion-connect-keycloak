<#import "template.ftl" as layout>
<@layout.registrationLayout; section >
    <div class="pre-register">
        <#if section = "header">
            <div class="title pre-register"><span>La plateforme de l'inclusion met en place</span></div>
        <#elseif section = "form">
            <form id="kc-register-form" class="${properties.kcFormClass!} pre-register" action="javascript:goToRegisterPage()">
                <div style="background-color:#FAFAFA;padding-top:30px;">
                    <img src="${url.resourcesPath}/img/logo-inclusion.png">
                    <div id="en-tete"><span>Utilisez le même identifiant et le même mot de passe sur plusieurs services.</span></div>
                    <img id="logos" src="${url.resourcesPath}/img/logos.png">
                    
                </div>
                <div class="${properties.kcFormGroupClass!}" >
                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}" style="margin-bottom:30px;">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                        </div>
                            
                    </div>
                     <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="Créer un compte Inclusion Connect"/>
                    </div>
                </div>
            </form>
        </#if>
    </div>
    <div class="register-form">
        <#if section = "header">
            <img src="${url.resourcesPath}/img/register.png">
            <img id="img-from" src="">
            <div id="en-tete"><span>Créer un compte Inclusion Connect vous permettra d'utiliser le même identifiant et le même mot de passe pour plusieurs services</span></div>
        <#elseif section = "form">
            <form id="kc-register-form" class="${properties.kcFormClass!} register-form" action="${url.registrationAction}" method="post">

                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" value="${(register.formData.lastName!'')}" />
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" value="${(register.formData.firstName!'')}" />
                    </div>
                </div>

                

                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="email" class="${properties.kcInputClass!}" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
                    </div>
                </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="username" class="${properties.kcInputClass!}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                    </div>
                </div>
            </#if>
                <div id="password-state">
                    <span>Créer un mot de passe avec au moins:</span>
                    <img id="length-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="length-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>8 caractères minimum</span>
                    <img id="number-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="number-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 chiffre</span>
                    <img id="capital-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="capital-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 majuscule</span>
                    <img id="character-criteria-1" src="${url.resourcesPath}/img/feedback-error-sign.png"><img id="character-criteria" src="${url.resourcesPath}/img/feedback-success-sign.png"><span>1 caractère spécial (ex: & é @ -)</span>
                </div>

                <#if passwordRequired??>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input onKeyPress="passwordCheck('password')" onKeyUp="passwordCheck('password')" type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password"><img onclick="showPassword('password')" id="show-password" height="25" src="${url.resourcesPath}/img/hide.png">
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="password" id="password-confirm" class="${properties.kcInputClass!}" name="password-confirm" /><img onclick="showPassword('password-confirm')" id="show-password-confirm" height="25" src="${url.resourcesPath}/img/hide.png">
                    </div>
                </div>
                </#if>

                <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
                </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}" style="margin-bottom:30px;">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                        </div>
                            
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doRegister")}"/>
                    </div>
                </div>
            </form>
        </#if>
    </div>
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
        if ("pass" in localStorage) {
            var elements = document.getElementsByClassName("pre-register");
            for (var i = 0, len = elements.length; i < len; i++) {
                elements[i].style.display = "none";
            }

            var elements = document.getElementsByClassName("register-form");
            for (var i = 0, len = elements.length; i < len; i++) {
                elements[i].style.display = "block";
            }
        }
    }
</script>