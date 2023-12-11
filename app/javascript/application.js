// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

document.addEventListener('turbo:load', function() {
    $(document).ready(function(){
      $('.detailImagesSlider').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 800,
        dots: false, 
        arrows: false,
        // adaptiveHeight: true,
      });
    });
  })


