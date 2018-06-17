function initMap() {
  var tokyo = {lat: 35.681167, lng: 139.767052};
  var zoom = 2;
  var map = new google.maps.Map(document.getElementById('map'), {
    center: tokyo,
    zoom: zoom,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var contentString = 'test';

  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  var marker = new google.maps.Marker({
    position: tokyo,
    map: map,
    title: 'Uluru (Ayers Rock)'
  });
  // window.onload = function() {
  //   infowindow.open(map, marker);
  // };
  // while (zoom < 16){
  //   setTimeout(function(){
  //     map.setZoom(zoom);
  //     zoom++;
  //   },100);
  // }
  setTimeout(function(){
    map.panTo(new google.maps.LatLng(35.566397,139.658153));
  },3000);
}
