# frozen_string_literal: true

module Folio
  class Atom < ApplicationRecord
    # Relations
    belongs_to :node

    def cell_name
      nil
    end

    def partial_name
      model_name.param_key
    end

    def data
      content
    end
  end
end

# == Schema Information
#
# Table name: folio_atoms
#
#  id         :integer          not null, primary key
#  type       :string
#  node_id    :integer
#  content    :text
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_folio_atoms_on_node_id  (node_id)
#
