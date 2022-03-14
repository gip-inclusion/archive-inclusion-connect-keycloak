<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <img src="${url.resourcesPath}/img/logo-inclusion.png">
        <img id="img-from" src="">
    <#elseif section = "form">
        <div id="kc-error-message">
            <p class="instruction">${message.summary?no_esc}</p>
            <#if client?? && client.baseUrl?has_content>
                <p><a id="backToApplication" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
            </#if>
        </div>
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