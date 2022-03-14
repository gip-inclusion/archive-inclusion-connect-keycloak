<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <img src="${url.resourcesPath}/img/logo-inclusion.png">
        <img id="img-from" src="">
        <h2>${msg("pageExpiredTitle")}</h2>

    <#elseif section = "form">

        <p id="instruction1" class="instruction">
            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}">${msg("doClickHere")}</a> .
        </p>
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