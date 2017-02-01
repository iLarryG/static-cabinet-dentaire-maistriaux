//= require jquery
//= require bootstrap-sprockets
//= require_tree .
//= require materialize

$(document).ready(function(){
  var carousel_interval = 7000;
  $('.carousel.carousel-slider').carousel({
    full_width: true,
    indicators: true,
    time_constant: 1000
  });

  setInterval(function(){
    $('.carousel').carousel('next');
  }, carousel_interval);

    $('.button-collapse').sideNav({
      menuWidth: 240, // Default is 240
      edge: 'left', // Choose the horizontal origin
      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
      draggable: true // Choose whether you can drag to open on touch screens
    }
  );
  $('.parallax').parallax();
  $( '.swipebox' ).swipebox();
});
