$(document).on('turbolinks:load', function() {
  $("#use_billing").change(function(){
    if(this.checked) {
      $("#shipping").fadeOut('slow');
    }
    else {
      $("#shipping").fadeIn('slow');
    }
  });
});