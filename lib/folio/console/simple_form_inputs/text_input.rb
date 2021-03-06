# frozen_string_literal: true

SimpleForm::Inputs::TextInput.class_eval do
  def input(wrapper_options = nil)
    input_html_classes << 'folio-console-text-input'

    if options[:autosize]
      input_html_classes << 'folio-console-text-input--autosize'
    end

    if options[:locale]
      input_html_options['data-locale'] = options[:locale]
    end

    if options[:folio_label]
      input_html_classes << 'f-c-js-atoms-placement-label'
    elsif options[:folio_perex]
      input_html_classes << 'f-c-js-atoms-placement-perex'
    end

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.text_area(attribute_name, merged_input_options)
  end
end
