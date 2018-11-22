window.folioConsoleAtom ?= {}

window.folioConsoleAtom.switchStringField = ({ structure, $field, placeholder }) ->
  switch structure
    when 'string'
      present = true
      $field.removeAttr('hidden')
      $field.find('.form-control')
        .attr('placeholder', placeholder)
        .prop('disabled', false)
    else
      present = false
      $field.attr('hidden', true)
      $field.find('.form-control').prop('disabled', true)

  return present