# frozen_string_literal: true

require 'test_helper'

module Folio
  class NodeTest < ActiveSupport::TestCase
    test 'translate node with atoms' do
      node = create(:folio_node_with_atoms, atoms_count: 3)
      translation = node.translate!(:en)
      assert_equal translation.atoms.count, 3

      translation.update(published: true, published_at: 1.minute.ago)
      assert_equal translation, node.translate(:en)
    end

    test 'ancestry touch' do
      parent = create(:folio_node)
      updated_at = parent.updated_at

      create(:folio_node, parent: parent)
      assert updated_at < parent.reload.updated_at
    end
  end
end

# == Schema Information
#
# Table name: folio_nodes
#
#  id               :integer          not null, primary key
#  site_id          :integer
#  title            :string
#  slug             :string
#  perex            :text
#  content          :text
#  meta_title       :string(512)
#  meta_description :string(1024)
#  code             :string
#  ancestry         :string
#  type             :string
#  featured         :boolean
#  position         :integer
#  published        :boolean
#  published_at     :datetime
#  original_id      :integer
#  locale           :string(6)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_folio_nodes_on_ancestry      (ancestry)
#  index_folio_nodes_on_code          (code)
#  index_folio_nodes_on_featured      (featured)
#  index_folio_nodes_on_locale        (locale)
#  index_folio_nodes_on_original_id   (original_id)
#  index_folio_nodes_on_position      (position)
#  index_folio_nodes_on_published     (published)
#  index_folio_nodes_on_published_at  (published_at)
#  index_folio_nodes_on_site_id       (site_id)
#  index_folio_nodes_on_slug          (slug)
#  index_folio_nodes_on_type          (type)
#
