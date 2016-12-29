$(document).on('page:change', function() {

  $(document).on("mouseenter", '.well_record', function (event) {
    var remove_circle = $(this).find('td.remove_circle');
    remove_circle.css("visibility", "visible");

  }).on("mouseleave", '.well_record', function () {
    var remove_circle = $(this).find('td.remove_circle');
    remove_circle.css("visibility", "hidden");
  });



});