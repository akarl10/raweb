<%@ Page language="C#" explicit="true"  %>
<script runat="server">
    public string getAuthenticatedUser() {
        HttpCookie authCookie = HttpContext.Current.Request.Cookies[".ASPXAUTH"];
        if(authCookie == null || authCookie.Value == "") return "";
        try {
            // Decrypt may throw an exception if authCookie.Value is total gargbage
            FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            if(authTicket==null) {
                return "";
            }
            return authTicket.Name;
        }
        catch {
            return "";
        }
    }
</script>
<%
  string authUser = getAuthenticatedUser();
  if(authUser=="") {
     Response.Redirect("auth/login.aspx?ReturnUrl="+Uri.EscapeUriString(HttpContext.Current.Request.Url.AbsolutePath));
  }
  else {
%>
<html>
<head>
<title>
RAWeb - Remote Applications
</title>
<style type="text/css">
a:link {color:#444444;text-decoration:none;}
a:visited {color:#444444;text-decoration:none;}
a:hover{color:#000000;text-decoration:underline;}
a:active {color:#000000;text-decoration:underline;}
   #apptile
{
width:150px;
height:135px;
text-align:center;
vertical-align:bottom;
border-style:solid;
border-width:0px;
float:left;
font-size:14px;
font-weight:bold;
}
h1 {
    font-family:Arial, Helvetica, sans-serif;
    font-size: 30px;
    font-style: italic;
    color:rgb(0,0,0)
}
body
{
font-family:Arial,sans-serif;
}
</style>
<link rel="shortcut icon" href="favicon.ico">
<script src="default.js" type="application/javascript"></script>
</head>
<body onload="loadWebFeed('webfeed.aspx',document.getElementById('applist'))">
<div style="text-align:left;"><h1>Remote<font style="color:rgb(100,100,100)">Apps</font></h1></div><br>
<div id="applist">
</div>
</body>
</html>
<%
  }
%>
