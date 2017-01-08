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

function sendRecordUpdate(el, new_content){
  var context = getRecordContext(el);
  //var record = el.closest('.'+ context +'_record');
  //var record_attr = el.closest('.record_attribute');
  //var context_id = record.data(context + 'id');
  //var param_key = record_attr.data("name");
  //$.ajax({
  //  method: 'PUT',
  //  url: '/basin_metrics/' + context + 's/' + context_id,
  //  data: param_key + '=' + new_content,
  //  dataType: 'script'
  //});
  //cleanNulls(el, new_content);
}

function getRecordContext(el) {
  var el_class = el.closest('tr').attr('class');
  if (el_class.indexOf('well') >= 0){
    return 'well';
  } else if (el_class.indexOf('part') >= 0){
    return 'part';
  }
}

function setNullableRecordFieldColors() {
  //$('.record_attribute.nullable div').each(function(index){
  //  cleanNulls($(this), $(this).text());
  //});
}