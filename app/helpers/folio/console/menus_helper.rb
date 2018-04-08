# frozen_string_literal: true

module Folio
  module Console::MenusHelper
    def menu_targets_for_select(menu)
      # STI hack
      menu.available_targets.map do |record|
        label = [
          record.class.model_name.human,
          record.title,
        ].join(' / ')

        value = [
          record.type,
          record.id
        ].join(::Folio::Console::MenusController::TYPE_ID_DELIMITER)

        [label, value]
      end.sort_by(&:first)
    end

    def menu_target_value(menu_item)
      return nil if menu_item.target.blank?

      [
        menu_item.target_type,
        menu_item.target_id
      ].join(::Folio::Console::MenusController::TYPE_ID_DELIMITER)
    end
  end
end
