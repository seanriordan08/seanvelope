
function hideTabMenus(el){
  if (el.hasClass('logo_icon'))
    return;
  $('.tab_panel').each(function() {
    $(this).animate({opacity: 0}, 30).hide();
  });
}

function toggleTabPanel(el){
  if (el.hasClass('logo_icon'))
    return;

  var top = el.position().top.toString() + "px";
  var panel = el.find('.tab_panel');
  if (el.hasClass('selected')){
    panel.css({top: top}).animate({opacity: 1}, 30).show();
  } else {
    panel.animate({opacity: 0}, 30).hide();
  }
}