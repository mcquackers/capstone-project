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
  $("#save-route").click(function() {
    var courseName = $("#course_name").val();
    var legs = directionsRenderer.directions.routes[0].legs;
    var distance = totalDistance(legs);
    saveRoute(distance, courseName);
    window.location.href = "/areas/"+ $("#map-pane").data("id") + "/courses";
  }); 
}

function saveRoute(distance, courseName) {
  var courseData = {
    course: {
      start_point_attributes: {
        lat: window.startLatLng.lat(),
        lng: window.startLatLng.lng()
      },
      end_point_attributes: {
        lat: window.endLatLng.lat(),
        lng: window.endLatLng.lng()
      },
      distance: distance,
      name: courseName
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

function totalDistance(legs) {
  var summedDistance = 0;
  for(var i = 0; i < legs.length; i++) {
    summedDistance += legs[i].distance.value;
  }
  return summedDistance;
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
