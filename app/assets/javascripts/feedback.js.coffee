$(document).ready ->
  form = $('#feedbackModal #new_feedback')

  genAlertbox = (type, text) ->
    """
      <div class="alert-box #{type}">
        #{text}
        <a href="" class="close">&times;</a>
      </div>
    """

  flushErrors = () ->
    form.find('.error').each ->
      error_div = $(this)
      error_div.find('small').remove()
      error_div.removeClass('error')

  hideSubmit = () ->
    $('#feedbackSubmitButton').hide()
    $('#feedbackSendingText').show()

  showSubmit = () ->
    $('#feedbackSubmitButton').show()
    $('#feedbackSendingText').hide()

  form.bind 'ajax:before', () ->
    hideSubmit()

  form.bind 'ajax:success', (evt, data, status, xhr) ->
    showSubmit()

    success_html = genAlertbox('success', 'Feedback sended. Thank you!')
    $('#content').prepend($(success_html))
    $('#feedbackModal').trigger('reveal:close')

    # clear inputs
    form.find('.row input:not(.button),textarea').val('')
    flushErrors()

  form.bind 'ajax:error', (evt, xhr, status, error) ->
    showSubmit()

    try
      errors = $.parseJSON(xhr.responseText).errors
    catch e
      server_fail_html = genAlertbox('alert', 'Problems with server. Try again later.')
      $('#feedbackModal').prepend($(server_fail_html))
      return

    flushErrors()

    # render errors
    for field_name, error_list of errors
      field_div = form.find("#feedback_#{field_name}").parent()
      field_div.addClass('error')
      for error in error_list
        error_desc = "<small>#{error}</small>"
        field_div.append($(error_desc))