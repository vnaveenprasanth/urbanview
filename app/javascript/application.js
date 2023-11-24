// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
    $(document).ready(function(){
      $('.detailImagesSlider').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        autoplaySpeed: 500,
        dots: false, 
        arrows: false,
        // adaptiveHeight: true,
      });
    });
  })