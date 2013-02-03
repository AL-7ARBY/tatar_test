$(document).ready ->
  genAlertbox = (type, text) ->
    """
      <div class="alert-box #{type}">
        #{text}
        <a href="" class="close">&times;</a>
      </div>
    """

  form = $('#feedbackModal #new_feedback')

  form.bind 'ajax:success', (evt, data, status, xhr) ->
    success_html = genAlertbox('success', 'Feedback sended. Thank you!')
    $('#content').prepend($(success_html))
    $('#feedbackModal').trigger('reveal:close')

  form.bind 'ajax:error', (evt, xhr, status, error) ->
    try
      errors = $.parseJSON(xhr.responseText).errors
    catch e
      server_fail_html = genAlertbox('alert', 'Problems with server. Try again later.')
      $('#feedbackModal').prepend($(server_fail_html))
      return

    # flush prev errors
    form.find('.error').each ->
      error_div = $(this)
      error_div.find('small').remove()
      error_div.removeClass('error')

    # render errors
    for field_name, error_list of errors
      field_div = form.find("#feedback_#{field_name}").parent()
      field_div.addClass('error')
      for error in error_list
        error_desc = "<small>#{error}</small>"
        field_div.append($(error_desc))