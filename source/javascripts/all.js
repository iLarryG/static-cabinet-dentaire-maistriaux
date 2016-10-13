//= require jquery
//= require bootstrap-sprockets
//= require_tree .
//= require materialize

$(document).ready(function(){
  var carousel_interval = 5000;
  $('.carousel.carousel-slider').carousel({
    full_width: true,
    indicators: true,
    time_constant: 500
  });
  setInterval(function(){
    $('.carousel').carousel('next');
  }, carousel_interval);
});
