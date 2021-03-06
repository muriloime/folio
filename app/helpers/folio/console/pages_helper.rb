# frozen_string_literal: true

module Folio::Console::PagesHelper
  def page_breadcrumbs(ancestors)
    unless ancestors.nil?
      links = ancestors.collect do |page|
        link_to(page.title, edit_console_page_path(page))
      end
      links.join(' / ')
    end
  end

  def new_child_page_button(parent)
    new_button(
      new_console_page_path(parent: parent.id),
      label: Folio::Page.model_name.human,
      title: t('folio.console.pages.page_row.add_child_page')
    )
  end

  def arrange_pages_with_limit(pages, limit)
    arranged = ActiveSupport::OrderedHash.new
    min_depth = Float::INFINITY
    index = Hash.new { |h, k| h[k] = ActiveSupport::OrderedHash.new }

    pages.each do |page|
      children = index[page.id]
      index[page.parent_id][page] = children

      depth = page.depth
      if depth < min_depth
        min_depth = depth
        arranged.clear
      end

      break if !page.root? && index[page.parent_id].count >= limit

      arranged[page] = children if depth == min_depth
    end
    arranged
  end
end
