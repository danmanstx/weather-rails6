function initMap(){
  var autocomplete = new google.maps.places.Autocomplete($("#address")[0], {});

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      // console.log(place.address_components);
  });
}

export default initMap;