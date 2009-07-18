<html>
<head><title>FireBrowser</title>
  <!-- Dependency -->
  <script src="http://yui.yahooapis.com/2.7.0/build/yahoo/yahoo-min.js"></script>
  <script src="http://yui.yahooapis.com/2.7.0/build/event/event-min.js"></script>
  <script src="http://yui.yahooapis.com/2.7.0/build/connection/connection-min.js"></script>
  <style type="text/css">
    #map {
      width: 100%;
      height: 100%;
    }
  </style>
</head>
<body>
<div id="map"></div>
<script type="text/javascript"
        src="http://www.google.com/jsapi?key=ABQIAAAASc66tF1r_zj5Xg3AoYQcERQ-aAkomW33b9jbcGp5OJNt_dzc5xRIpgil3bMcGN-m_TIcPyXoiM89Vg"></script>
<script type="text/javascript">
  var lat;
  var lon;

  var positionUpdated = {
    success: function(o) {
      createMap(lat, lon, "FireEagle updated!");
    },
    failure: function(o) {
    }
  }

  google.load("maps", "2.x");

  function found(position) {
    lat = position.coords.latitude;
    lon = position.coords.longitude;
    var latlon = "lat=" + lat + "&lon=" + lon;
    var transaction = YAHOO.util.Connect.asyncRequest('GET', "http://firebrowser.javarants.com/update?" + latlon, positionUpdated, null);
  }

  google.setOnLoadCallback(function() {
    var geolocator = navigator.geolocation.getCurrentPosition(found);
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
</body>
</html>
