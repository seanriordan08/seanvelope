$(document).on('page:change', function() {

  listRecordHighlights();
  attributeRecordHighlights();
  attributeContentEditable();
  attributeContentCheckable();

});

function listRecordHighlights() {
  $(document).on("mouseenter", '.list_table tr', function (event) {
    var remove_circle = $(this).find('td.remove_circle');
    remove_circle.css("visibility", "visible");
  }).on("mouseleave", '.list_table tr', function () {
    var remove_circle = $(this).find('td.remove_circle');
    remove_circle.css("visibility", "hidden");
  });
}

function attributeRecordHighlights() {
  $(document).on("mouseenter", '.record_attribute', function (event) {
    $(this).css({backgroundColor: '#364A56'})
  }).on("mouseleave", '.record_attribute', function() {
    $(this).css({backgroundColor: 'transparent'})
  });
}

function attributeContentEditable() {
  var changes_made = false;
  var all_ommitted_attributes = getNonEditableAttributes();

  $(document).on('click', 'td.record_attribute', function() {
    var that = $(this);
    if ($.inArray($(this).data("name"), all_ommitted_attributes) >= 0)
      return;

    $(this).keydown(function(){
      changes_made = true;
    });
    $(this).attr({contenteditable:'true',spellcheck:'false'}).focus().css({color: '#9faeaf'});
  }).on('blur', 'td.record_attribute', function(){
    $(this).off("keydown");
    var content = cleanNulls($(this).text());
    if (content != null){
      $(this).removeAttr('contenteditable').css({color: '#CCDBDC'});
    } else {
      content = 'none';
    }

    if (changes_made) {
      sendUpdate($(this), content);
      changes_made = false;
    }
    $('.comment').css({color:'#56717d'});

  });
}

function attributeContentCheckable() {
  var changes_made = false;
  $(document).on('click', "td.record_attribute input[type='checkbox']", function() {
    var text_state = $(this).next('span').text();
    if (text_state == 'Yes'){
      text_state = 'No';
      $(this).attr('value', 'false');
    } else if (text_state == 'No') {
      text_state = 'Yes';
      $(this).attr('value', 'true');
    }
    $(this).next('span').text(text_state);
    changes_made = true;
  }).on('mouseleave', 'td.record_attribute', function() {
    if (changes_made) {
      var content = $(this).find('input').attr('value');
      sendUpdate($(this), content);
    }
    changes_made = false;
  });
}

//Helpers

function cleanNulls(text) {
  var new_text = text;
  new_text = $.trim(new_text).toLowerCase();
  if ((new_text == 'none') || (new_text == '') || (new_text == 'n/a') || (new_text == 'na')){
    new_text = null;
    return new_text;
  } else {
    return text;
  }

}

function sendUpdate(el, content){
  var context = getContext(el);
  var context_id = el.closest('.'+ context +'_record').data(context + 'id');
  var param_key = el.data("name");
  $.ajax({
    method: 'PUT',
    url: '/basin_metrics/' + context + 's/' + context_id,
    data: param_key + '=' + content,
    dataType: 'script'
  });
}

function getNonEditableAttributes() {
  var omitted_well_attributes = ['pump_running','cemented', 'complete'];

  var omitted_global_attributes = ['customer_id','district_id', 'created_at', 'updated_at'];
  return omitted_global_attributes.concat(omitted_well_attributes);
}

function getContext(el) {
  var el_class = el.closest('tr').attr('class');
  if (el_class.includes('well')){
    return 'well';
  } else if (el_class.includes('part')){
    return 'part';
  }
}