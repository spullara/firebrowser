<%@ page import="net.oauth.OAuthAccessor" %>
<%@ page import="net.oauth.OAuthMessage" %>
<%@ page import="org.codehaus.jackson.JsonParser" %>
<%@ page import="org.codehaus.jackson.map.MappingJsonFactory" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="net.oauth.http.HttpClient" %>
<%@ page import="net.oauth.client.httpclient4.HttpClient4" %>
<%@ page import="net.oauth.client.OAuthClient" %>
<html>
<body>
<h2>Hello World!</h2>
<pre>
<%
  OAuthAccessor oa = (OAuthAccessor) request.getAttribute("oa");
  OAuthClient oc = (OAuthClient) request.getAttribute("oc");
  OAuthMessage om = oc.invoke(oa, "GET", "https://fireeagle.yahooapis.com/api/0.1/user.json", new HashMap().entrySet());
  String content = om.readBodyAsString();
  JsonParser jp = new MappingJsonFactory().createJsonParser(content);
%><%= jp.readValueAsTree() %>
</pre>
</body>
</html>
