window.startLatLng = null;
window.endLatLng = null;

function initialize() {
  var mapOptions = {
    zoom: 16
  };
  var rendererOptions = {
    draggable: true
  };
  var directionsRenderer = new google.maps.DirectionsRenderer(rendererOptions);
  var directionsService = new google.maps.DirectionsService();
  var map = new google.maps.Map(document.getElementById("map-pane"),
      mapOptions);
  directionsRenderer.setMap(map);
  directionsRenderer.setPanel(document.getElementById("directions-pane"));
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
          position.coords.longitude);

      map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    handleNoGeolocation(false);
  }

  var bikeLayer = new google.maps.BicyclingLayer();
  bikeLayer.setMap(map);

  google.maps.event.addListener(map, "click", function(event) {
    placeMarker(event.latLng, map);
  });

  $("#get-directions").click(function(){
    calcRoute(directionsRenderer, directionsService)
  });
}

function calcRoute(directionsRenderer, directionsService) {
  var request = {
    origin: window.startLatLng,
    destination: window.endLatLng,
    travelMode: google.maps.TravelMode.BICYCLING
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsRenderer.setDirections(response);
    }
  });
}

function placeMarker(latLng, map) {
  if(window.startLatLng === null){
    window.startLatLng = latLng;
    new google.maps.Marker({
      position: latLng,
      map: map
    });
  } else if(window.endLatLng === null){
    window.endLatLng = latLng;
    new google.maps.Marker({
      position: latLng,
      map: map
    });
  }
}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = "Error: The Geolocation service failed.";
  } else {
    var content = "Error: Your browser doesn't support geolocation.";
  }

  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}

google.maps.event.addDomListener(window, 'load', initialize);
