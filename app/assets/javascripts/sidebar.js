
$(document).on('page:change', function() {
  $('.sidebar li').on('click', function() {
    var el = $(this);
    hideTabSelections(el);
    hideTabPanels(el);
    emptyMainPanel();
    toggleTabSelection(el);

    if (el.find('.wells_icon').length > 0){
      $.ajax({
        method: 'get',
        url: "/basin_metrics/wells",
        dataType: 'script text'
      });
    }
  });
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

function emptyMainPanel(){
  $('.main_pane').trigger('main_pane:empty');
}