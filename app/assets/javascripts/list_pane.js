$(document).on('page:change', function() {

  wellRecordHighlights();
  attributeRecordHighlights();
  attributeContentEditable();

});

function wellRecordHighlights() {
  $(document).on("mouseenter", '.well_record', function (event) {
    var remove_circle = $(this).find('td.remove_circle');
    remove_circle.css("visibility", "visible");
  }).on("mouseleave", '.well_record', function () {
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
  var all_ommitted_attributes = getOmittedAttributes();

  $(document).on('click', 'td.record_attribute', function() {
    if ($.inArray($(this).data("name"), all_ommitted_attributes) >= 0) {
      console.log('omitted!');
      return;
    }

    $(this).keydown(function(){ changes_made = true; });
    $(this).attr({contenteditable:'true',spellcheck:'false'}).focus().css({color: '#9faeaf'});
  }).on('blur', 'td.record_attribute', function(){
    $(this).off("keydown");
    $(this).removeAttr('contenteditable').css({color: '#CCDBDC'});
    if (changes_made) {
      var well_id = $(this).closest('.well_record').data("wellid");
      var param_key = $(this).data("name");
      var content = $(this).text();
      $.ajax({
        method: 'PUT',
        url: "/basin_metrics/wells/" + well_id,
        data: param_key + '=' + content,
        dataType: 'script'
      });
      changes_made = false
    }
  });
}

function getOmittedAttributes() {
  var omitted_well_attributes = ['pump_running','cemented','complete'];

  var omitted_global_attributes = ['customer_id','district_id', 'created_at', 'updated_at'];
  return omitted_global_attributes.concat(omitted_well_attributes);
}