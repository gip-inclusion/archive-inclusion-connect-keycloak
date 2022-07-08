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