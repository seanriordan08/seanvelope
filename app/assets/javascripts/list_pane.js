$(document).on('page:change', function() {

  $('.list_pane').on("list_panel_empty", function () {
    $(this).empty();
  });

});