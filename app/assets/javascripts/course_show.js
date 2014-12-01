function initialize() {
  var mapOptions = {
    zoom: 16
  };
  var pane = $("#course-show-pane");
  var url = "/areas/" + pane.data("area-id") + "/courses/" + pane.data("course-id");
  var map = new google.maps.Map($("#course-show-pane")[0], mapOptions);
  var reqJson = $.getJSON(url);
  reqJson.done(function(data) {
    var startPoint = data.start_point;
    var endPoint = data.end_point;
    var midPoints = data.mid_points;
    loadDirections(startPoint, endPoint, midPoints, map);
  });
};

function loadDirections(startPoint, endPoint, midPoints, map) {
  var directionsRenderer = new google.maps.DirectionsRenderer();
  var directionsService = new google.maps.DirectionsService();
  var origin = new google.maps.LatLng(startPoint.lat, startPoint.lng);
  var destination = new google.maps.LatLng(endPoint.lat, endPoint.lng);
  var waypoints = $.map(midPoints, function(point) {
    return { location: new google.maps.LatLng(point.lat, point.lng) };
  });
  directionsRenderer.setMap(map);
  new google.maps.BicyclingLayer().setMap(map);
  calcRoutes(origin, destination, waypoints, directionsRenderer, directionsService);
};

function calcRoutes(start, end, waypoints, directionsRenderer, directionsService) {
  var request = {
    origin: start,
    destination: end,
    waypoints: waypoints,
    travelMode: google.maps.TravelMode.BICYCLING
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsRenderer.setDirections(response);
    }
  });
};

google.maps.event.addDomListener(window, 'load', initialize);
