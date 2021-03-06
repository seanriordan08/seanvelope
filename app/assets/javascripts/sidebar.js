
$(document).on('ready', function() {
  $('.sidebar li').on('click', function() {
    var el = $(this);
    hideTabSelections(el);
    hideTabMenus(el);
    toggleTabSelection(el);

    // Omit tabs
    //var customer_selected = el.find('.customers_icon').length;

    emptyMainPane();
    activateMainPane(el);
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
    //toggleTabMenu(el);
  }
}

function emptyMainPane(){
  $('.main_pane').trigger('main_pane:empty');
}

function activateMainPane(el) {
  var context = 'dashboard';
  if (el.find('.maps_icon').length > 0)
    context = 'maps';
  if (el.find('.customers_icon').length > 0)
    context = 'customers';
  if (el.find('.districts_icon').length > 0)
    context = 'districts';
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