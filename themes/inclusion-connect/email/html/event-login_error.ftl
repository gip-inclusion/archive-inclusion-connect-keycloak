<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<body>
${kcSanitize(msg("greetingHtml"))?no_esc}
${kcSanitize(msg("eventLoginErrorBodyHtml",event.date,event.ipAddress))?no_esc}
${kcSanitize(msg("closingHtml"))?no_esc}
</body>
</html>
