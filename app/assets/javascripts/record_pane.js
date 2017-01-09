$(document).on('ready', function() {

  recordAttributeContentEditable();

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

function recordAttributeContentEditable() {
  var changes_made = false;
  var all_ommitted_attributes = getNonEditableAttributes();

  $(document).on('click', 'td.record_attribute div', function() {
    if ($.inArray($(this).data("name"), all_ommitted_attributes) >= 0)
      return;

    $(this).keydown(function(){
      changes_made = true;
    });
    $(this).attr({contenteditable:'true',spellcheck:'false'}).focus().css({color: '#9faeaf'});
  }).on('blur', 'td.record_attribute div', function(){
    $(this).off("keydown");
    var content = cleanNulls($(this), $(this).text());
    if (content != null){
      $(this).removeAttr('contenteditable').css({color: '#CCDBDC'});
    } else {
      content = 'none';
    }

    if (changes_made) {
      sendUpdate($(this), content);
      changes_made = false;
    }

  });
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