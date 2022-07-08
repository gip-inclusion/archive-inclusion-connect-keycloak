<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <img src="${url.resourcesPath}/img/logo-inclusion.png">
        <img id="img-from" src="">
    <#elseif section = "form">
        <p class="instruction">
            ${msg("emailVerifyInstruction1")}
        </p>
        <p class="instruction">
            ${msg("emailVerifyInstruction2")} <a href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
        </p>
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