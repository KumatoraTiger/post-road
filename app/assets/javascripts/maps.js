$('#generate_map').on('click', function(){
  moveMap($(this).val());
});

function moveMap(tweets) {
  var promise = new Promise((resolve, reject) => {
    resolve();
  });

  promise.then(() => {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        map.setZoom(7);
        resolve();
      }, 1500);
    })
  }).then(() => {
    promise = new Promise((resolve, reject) => {
      setTimeout(() => {
        map.setZoom(15);
        resolve();
      },1500);
    });
  }).catch(() => {
    console.error('Something wrong!')
  })

  $.each(tweets, function(index,tweet){
    promise.then(() => {
      promise = new Promise((resolve, reject) => {
        setTimeout((tweet) => {
          map.panTo(new google.maps.LatLng());
          resolve();
        }, 1000);
      });
    }).catch(() => {
      console.error('Something wrong!')
    })
  });

  //   setTimeout(() => {
  //     map.panTo(new google.maps.LatLng(35.566397,139.658153));
  //   },1000);
  // }).catch(() => {
  // })
  //
  // var contentString = 'test';
  //
  // var infowindow = new google.maps.InfoWindow({
  //   content: contentString
  // });
  //
  // var marker = new google.maps.Marker({
  //   position: tokyo,
  //   map: map,
  //   title: 'Uluru (Ayers Rock)'
  // });
  // window.onload = function() {
  //   infowindow.open(map, marker);
  // };
  // while (zoom < 16){
  //   setTimeout(function(){
  //     map.setZoom(zoom);
  //     zoom++;
  //   },100);
  // }
  // console.log(zoom);
  // setTimeout(function(){
  //   map.setZoom(7);
  // }, 2000)
  //
  // let promise = new Promise((resolve, reject) => {
  //   resolve(
  //     {setTimeout(function(){
  //       map.setZoom(7);
  //     },1500);
  // })
  //
  //
  // setTimeout(function(){
  //   map.setZoom(15);
  //   map.panTo(new google.maps.LatLng(35.566397,139.658153));
  // },1000);
}
