/**
 * Created by seanriordan08 on 12/3/16.
 */

$(document).on('page:change', function() {
  $('.ruby').animate({width: '75%'}, { duration: 4000, easing: "easeOutExpo"});
  $('.design').animate({width: '75%'}, { duration: 4000, easing: "easeOutExpo"});
  $('.javascript').animate({width: '60%'}, { duration: 4000, easing: "easeOutExpo"});
  $('.testing').animate({width: '80%'}, { duration: 4000, easing: "easeOutExpo"});
  $('.dev_ops').animate({width: '45%'}, { duration: 4000, easing: "easeOutExpo"});
});