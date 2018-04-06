# frozen_string_literal: true

module Folio
  class LeadFormCell < SavingFolioCell
    include InvisibleCaptcha::ViewHelpers
    include SimpleForm::ActionViewExtensions::FormHelper
    include Engine.routes.url_helpers

    def lead
      @lead ||= (model || Lead.new)
    end

    def submitted
      !lead.new_record?
    end

    def note
      return options[:note] if options[:note]
      model.note if model
    end

    def note_label
      return options[:note_label] if options[:note_label]
      t('.note') if model
    end

    def message
      return options[:message] if options[:message]
      t('.message')
    end

    def remember_option_keys
      [:note, :message, :name, :note_label]
    end

    private

      # fix content_tag
      # https://github.com/trailblazer/cells-slim/issues/14
      def tag_builder
        super.tap { |builder| builder.class_eval { include Cell::Slim::Rails } }
      end
  end
end
