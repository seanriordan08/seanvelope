$(document).on('ready', function() {

  $('.close_circle a').on("record_pane:close", function (e) {
    e.preventDefault();
    closeRecordPaneDirectly();
  });

});

function emptyMainPane(){
  $('.close_circle a').trigger('record_pane:close');
}

function closeRecordPaneDirectly(el){
  el.animate({
    right: '-25%'
  },{
    duration: 200, easing: "easeInExpo"
  });
  el.removeClass('showing');
}