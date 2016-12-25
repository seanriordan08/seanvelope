
function hideTabPanels(el){
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
    //el.css({borderRight:'3px solid transparent'});
  } else {
    panel.animate({opacity: 0}, 30).hide();
    //el.css({borderRight:'3px solid #33A8AA'});
  }
}