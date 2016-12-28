$(document).on('page:change', function() {

  $('.main_pane').on("main_pane:empty", function () {
    $(this).empty();
  });

});