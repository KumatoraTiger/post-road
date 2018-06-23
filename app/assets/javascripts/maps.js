// $(window).on('load', function(){
//   console.log($('#genarate_map').val());
//   moveMap($('#genarate_map').val());
// });
// function initialMove(){
//   var promise = new Promise((resolve, reject) => {
//     resolve();
//   });
//
//   promise.then(() => {
//     return new Promise((resolve, reject) => {
//       setTimeout(() => {
//         map.setZoom(7);
//         resolve();
//       }, 1500);
//     })
//   }).then(() => {
//     setTimeout(() => {
//       map.setZoom(15);
//       resolve();
//     },1500);
//   }).catch(() => {
//     console.error('Something wrong!')
//   })
// }

function infoWindow(map){
  var map = new google.maps.Map(document.getElementById('map'), {
    center: tweets[0]["geo"],
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  $.each(tweets, function(idx, tweet){
    var position = tweet["geo"];
    var content = tweet["oembed_html"];

    var infowindow = new google.maps.InfoWindow({
      content: content
    });
    var marker = new google.maps.Marker({
      position: position,
      map: map,
      title: 'test'
    })
    infowindow.open(map, marker);
    console.log(tweet["geo"]);
    console.log(tweet["oembed_html"]);
  });
}

// function moveMap(lat, lng, oembed) {
//   $.each(tweets, function(index,tweet){
//     promise.then(() => {
//       promise = new Promise((resolve, reject) => {
//         setTimeout((tweet) => {
//           map.panTo(new google.maps.LatLng(tweeet[:geo][:lat],tweeet[:geo][:lng]));
//           resolve();
//         }, 1000);
//       });
//     }).catch(() => {
//       console.error('Something wrong!')
//     })
//   });
// }
