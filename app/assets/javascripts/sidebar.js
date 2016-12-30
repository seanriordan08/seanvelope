
$(document).on('page:change', function() {
  $('.sidebar li').on('click', function() {
    console.log('hit');
    var el = $(this);
    hideTabSelections(el);
    hideTabMenus(el);
    toggleTabSelection(el);

    var customer_selected = el.find('.customers_icon').length;
    var district_selected = el.find('.districts_icon').length;

    if ((customer_selected == 0) && (district_selected == 0)){
      emptyMainPane();
      activateMainPane(el);
    }
  });

  $('.maps_icon').click();
});

function hideTabSelections(el){
  if (el.hasClass('logo_icon'))
    return;
  $('.sidebar li').each(function() {
    $(this).css({borderRight:'3px solid transparent'}).removeClass('selected');
  });
}

function toggleTabSelection(el){
  if (el.hasClass('logo_icon'))
    return;
  if (el.hasClass('selected')){
    el.css({borderRight:'3px solid transparent'}).removeClass('selected');
  } else {
    el.css({borderRight:'3px solid #33A8AA'}).addClass('selected');
    toggleTabPanel(el);
  }
}

function emptyMainPane(){
  $('.main_pane').trigger('main_pane:empty');
}

function activateMainPane(el) {
  var context = 'dashboard';
  if (el.find('.maps_icon').length > 0)
    context = 'maps';
  if (el.find('.wells_icon').length > 0)
    context = 'wells';
  if (el.find('.parts_icon').length > 0)
    context = 'parts';
  $.ajax({
    method: 'get',
    url: "/basin_metrics/" + context,
    dataType: 'script text'
  });
}