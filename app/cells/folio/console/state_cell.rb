# frozen_string_literal: true

class Folio::Console::StateCell < Folio::ConsoleCell
  include SimpleForm::ActionViewExtensions::FormHelper

  def show
    render if model.aasm_state.present?
  end

  def state
    @state ||= model.aasm.state_object_for_name(model.aasm_state.to_sym)
  end

  def state_square(s = nil)
    s ||= state
    color = s.options[:color].presence || 'default'

    content_tag(:span, '', class: 'f-c-state__state-square '\
                                  "f-c-state__state-square--color-#{color} "\
                                  "f-c-state__state-square--state-#{s.name} "\
                                  "f-c-state__state-square--model-#{model.class.table_name}")
  end

  def states
    @states ||= model.aasm.states.map do |state|
      {
        name: state.name,
        human_name: state.human_name,
        color: state.options.color.presence || 'default',
      }
    end
  end

  def form(&block)
    opts = {
      method: :post,
      url: options[:url] || url_for([:event, :console, model]),
    }
    simple_form_for '', opts, &block
  end

  def target_state(event)
    to = event.transitions.first.to

    if to.is_a?(Array)
      to = model.try(:previous_aasm_state).try(:to_sym) || to.first
    end

    model.aasm.state_object_for_name(to)
  end

  def active?
    options[:active] != false
  end
end
