$(document).on('ready', function() {

  //recordAttributeContentEditable();

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
    right: '-45%'
  },{
    duration: 200, easing: "easeInExpo"
  });
  el.removeClass('showing');
}

function setLockTrigger(well_id){
  $(document).on('click', '.record_pane .unlocked', function() {
    console.log('unlocked');
    var inventory_value = $(this).siblings('select.number_selector').find('option:selected').text();
    var qty_value = $(this).siblings('input.number_selector').val();
    if ((inventory_value && qty_value) && (qty_value > 0)) {
      $.ajax({
        method: 'POST',
        url: "/basin_metrics/reservations/" + well_id,
        dataType: 'script',
        data: {inventory_value: inventory_value, qty_value: qty_value}
      })
    }
  });
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
      debugger;
      sendUpdate($(this), content);
      changes_made = false;
    }

  });
}