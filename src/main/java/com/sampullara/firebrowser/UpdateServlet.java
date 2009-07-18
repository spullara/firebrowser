package com.sampullara.firebrowser;

import net.oauth.client.OAuthClient;
import net.oauth.OAuthAccessor;
import net.oauth.OAuthException;
import net.oauth.OAuthMessage;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.net.URISyntaxException;

/**
 * Update their location
 * 
 * User: samp
 * Date: Jul 17, 2009
 * Time: 7:09:53 PM
 * To change this template use File | Settings | File Templates.
 */
public class UpdateServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String lat = req.getParameter("lat");
    String lon = req.getParameter("lon");
    if (lat != null && lon != null) {
      OAuthClient oc = (OAuthClient) req.getAttribute("oc");
      OAuthAccessor oa = (OAuthAccessor) req.getAttribute("oa");
      if (oc != null && oa != null) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("lat", lat);
        params.put("lon", lon);
        OAuthMessage om;
        try {
          om = oc.invoke(oa, "POST", "https://fireeagle.yahooapis.com/api/0.1/update.xml", params.entrySet());
        } catch (OAuthException e) {
          resp.sendError(401, "Failed to update");
          return;
        } catch (URISyntaxException e) {
          resp.sendError(500, "Failed to update");
          return;
        }
        resp.setContentType("application/xml");
        resp.getWriter().write(om.readBodyAsString());
      }
    }
  }
}
