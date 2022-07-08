<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <img src="${url.resourcesPath}/img/logo-inclusion.png">
        <img id="img-from" src="">
        <div>
            <#if code.success>
                ${msg("codeSuccessTitle")}
            <#else>
                ${msg("codeErrorTitle", code.error)}
            </#if>
        
        </div>
        
    <#elseif section = "form">
        <div id="kc-code">
            <#if code.success>
                <p>${msg("copyCodeInstruction")}</p>
                <input id="code" class="${properties.kcTextareaClass!}" value="${code.code}"/>
            <#else>
                <p id="error">${code.error}</p>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
<script>
    var img = document.getElementById("img-from")
    var from = localStorage.getItem("from");
    if (from == 'dora') {
      img.src = "https://i.goopics.net/pnj9ji.png";
    } else if (from == 'communaute') {
      img.src = "https://i.goopics.net/5w86fe.png";
    } else if (from == 'emplois') {
      img.src = "https://i.goopics.net/fyzv6q.png";
    } else {
      img.src = "";
    }
</script>
<style>