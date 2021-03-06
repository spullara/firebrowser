<html>
<head><title>BrowFire</title>
  <!-- Dependency -->
  <script src="http://yui.yahooapis.com/2.7.0/build/yahoo/yahoo-min.js"></script>
  <script src="http://yui.yahooapis.com/2.7.0/build/event/event-min.js"></script>
  <script src="http://yui.yahooapis.com/2.7.0/build/connection/connection-min.js"></script>
  <script type="text/javascript" src="gears_init.js"></script>
  <style type="text/css">
    #map {
      width: 100%;
      height: 100%;
    }
  </style>
</head>
<body>
<div>
<a href="http://www.javarants.com/2009/07/17/update-your-fireeagle-location-automatically-from-any-browser/">More information...</a>  
</div>
<div id="map"></div>
<div id="log"></div>
<script type="text/javascript"
        src="http://www.google.com/jsapi?key=ABQIAAAASc66tF1r_zj5Xg3AoYQcERQX4BOKJOcifbeh9S1UK70t9X27cBRFmgybjPbN3AS4eXEF8_nE1nY5-Q"></script>
<script type="text/javascript">
  var lat;
  var lon;
  var map;

  var positionUpdated = {
    success: function(o) {
      if (map != undefined) {
        createMap(lat, lon, "FireEagle updated!");
      } else {
        map.setCenter(new google.maps.LatLng(lat, lon), 13);
        map.openInfoWindow(map.getCenter(), document.createTextNode(location));
      }
    },
    failure: function(o) {
      log("Failed to update FireEagle location.");
    }
  }

  google.load("maps", "2.x");

  function locate(lat, lon) {
    var latlon = "lat=" + lat + "&lon=" + lon;
    log("Located at " + lat + ", " + lon);
    var transaction = YAHOO.util.Connect.asyncRequest('GET', "http://browfire.com/update?" + latlon, positionUpdated, null);
  }

  function html5Locate(position) {
    locate(lat = position.coords.latitude, lon = position.coords.longitude);
  }

  function gearsLocate(position) {
    locate(lat = position.latitude, lon = lon = position.longitude);
  }

  function log(message) {
    var p = document.createElement("p");
    p.innerHTML = message;
    document.getElementById("log").appendChild(p);
  }

  function errorHandler(error) {
    log(error.message);
  }

  google.setOnLoadCallback(function() {
    log("Checking capabilities...");
    if (navigator.geolocation) {
      log("HTML5 Geolocation API support");
      navigator.geolocation.watchPosition(html5Locate, errorHandler, {maximumAge:600000});
    } else if (window.google && google.gears) {
      log("Gears GeoLocation API support");
      var geo = google.gears.factory.create('beta.geolocation');
      geo.watchPosition(gearsLocate, errorHandler, {maximumAge:600000});
    } else {
      log("Falling back to Google ClientLocation using IP");
      var cl = google.loader.ClientLocation;
      if (cl) {
        locate(lat = cl.latitude, lon = cl.longitude);
      }
    }
  });

  function createMap(lat, lng, location) {
    var mapElement = document.getElementById("map");
    mapElement.style.display = 'block';
    map = new google.maps.Map2(mapElement);
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());
    map.setCenter(new google.maps.LatLng(lat, lng), 13);
    map.openInfoWindow(map.getCenter(), document.createTextNode(location));
  }

  log("Initializing...");
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
