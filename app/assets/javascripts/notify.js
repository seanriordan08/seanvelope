
function triggerNotification(success, error) {
  var confirmation_success = success;
  var confirmation_error = error;

  if (confirmation_success != '') {
    $.notify({
      message: success
    },{
      type: 'success'
    });
  }
  if (confirmation_error != '') {
    $.notify({
      message: error
    },{
      type: 'danger'
    });
  }
}