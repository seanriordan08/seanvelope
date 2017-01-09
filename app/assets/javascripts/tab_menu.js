
function hideTabMenus(el){
  if (el.hasClass('logo_icon'))
    return;
  $('.tab_panel').each(function() {
    $(this).animate({opacity: 0}, 30).hide();
    el.find('.tab_panel').removeClass('shown');;
  });
}

function toggleTabMenu(el){
  if (el.hasClass('logo_icon'))
    return;

  var top = el.position().top.toString() + "px";
  var panel = el.find('.tab_panel');

  if (el.hasClass('selected')){
    if (panel.hasClass('shown')){
      panel.animate({opacity: 0}, 30).hide();
      panel.removeClass('shown');
    } else {
      panel.css({top: top}).animate({opacity: 1}, 30).show();
      panel.addClass('shown');
    }
  } else {
    panel.animate({opacity: 0}, 30).hide();
    panel.removeClass('shown');
  }
}