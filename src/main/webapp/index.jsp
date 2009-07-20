<html>
<head><title>FireBrowser - FireEagle Updater</title></head>
<!-- Dependency -->
<script src="http://yui.yahooapis.com/2.7.0/build/yahoo/yahoo-min.js"></script>
<script src="http://yui.yahooapis.com/2.7.0/build/event/event-min.js"></script>
<script src="http://yui.yahooapis.com/2.7.0/build/get/get-min.js"></script>
<script src="http://yui.yahooapis.com/2.7.0/build/connection/connection-min.js"></script>
<body>
<div id="map"></div>
<script type="text/javascript"
        src="http://www.google.com/jsapi?key=ABQIAAAASc66tF1r_zj5Xg3AoYQcERQ-aAkomW33b9jbcGp5OJNt_dzc5xRIpgil3bMcGN-m_TIcPyXoiM89Vg"></script>
<script type="text/javascript">
  var positionUpdated = {
    success: function(o) {},
    failure: function(o) {}
  }

  google.load("maps", "2.x");

  google.setOnLoadCallback(function() {
    if (google.loader.ClientLocation) {
      var cl = google.loader.ClientLocation;
      var location = [cl.address.city, cl.address.region, cl.address.country].join(', ');
      var latlon = "lat=" + cl.latitude + "&lon=" + cl.longitude;
      var transaction = YAHOO.util.Connect.asyncRequest('GET', "http://firebrowser.javarants.com/update", positionUpdated, latlon);
      createMap(cl.latitude, cl.longitude, location);
    } else {
      document.getElementById('cantfindyou').innerHTML = "Crap, I don't know. Good hiding!";
    }
  });

  function createMap(lat, lng, location) {
    var mapElement = document.getElementById("map");
    mapElement.style.display = 'block';
    var map = new google.maps.Map2(mapElement);
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());
    map.setCenter(new google.maps.LatLng(lat, lng), 13);
    map.openInfoWindow(map.getCenter(), document.createTextNode(location));
  }
</script>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-9858369-1");
pageTracker._trackPageview();
} catch(err) {}</script>
</body>
</html>
