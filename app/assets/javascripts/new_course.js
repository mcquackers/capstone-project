window.stops = [];
window.waypoints = [];
window.start = null;
window.end = null;

function initialize() {
  var mapOptions = {
    zoom: 16
  };
  var directionsRenderer = new google.maps.DirectionsRenderer();
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

  new google.maps.BicyclingLayer().setMap(map);

  google.maps.event.addListener(map, "click", function(event) {
    placeMarker(event.latLng, map);
  });

  $("#get-directions").click(function(){
    calcRoute(directionsRenderer, directionsService)
  });
  $("#save-route").click(function() {
    var courseName = $("#course_name").val();
    var courseDescription = $("#course_description").val();
    var legs = directionsRenderer.directions.routes[0].legs;
    var distance = totalDistance(legs);
    saveRoute(distance, courseName, courseDescription);
    window.location.href = "/areas/"+ $("#map-pane").data("id") + "/courses";
  }); 
}

function saveRoute(distance, courseName, courseDescription) {
  var courseData = {
    course: {
      waypoints_attributes: window.stops,
      distance: distance,
      name: courseName,
      description: courseDescription
    }
  };
  var area_id = $("#map-pane").data("id");
  $.ajax({
    url: "/areas/" + area_id + "/courses",
    type: "POST",
    data: courseData
  });
}

function calcRoute(directionsRenderer, directionsService) {
  var request = {
    origin: window.start,
    destination: window.end,
    waypoints: window.waypoints,
    travelMode: google.maps.TravelMode.BICYCLING
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      $("#save-route").removeAttr("disabled");
      directionsRenderer.setDirections(response);
    }
  });
}

function totalDistance(legs) {
  var summedDistance = 0;
  for(var i = 0; i < legs.length; i++) {
    summedDistance += legs[i].distance.value;
  }
  return summedDistance;
}

function placeMarker(latLng, map) {
  new google.maps.Marker({
    position: latLng,
    map: map
  });
  if (window.stops.length < 10) {
    if (window.start == null) {
      window.start = latLng;
    } else if (window.end == null) {
      window.end = latLng;
    } else {
      window.waypoints.push({ location: window.end, stopover: true });
      window.end = latLng;
    }
    window.stops.push({
      lat: latLng.lat(),
      lng: latLng.lng(),
      order: window.stops.length,
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
