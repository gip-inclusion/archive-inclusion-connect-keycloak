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
    setLogo()
</script>