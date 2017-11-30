# frozen_string_literal: true

module Folio
  module OpenGraphHelper
    def og_title
      @og_title.presence || public_page_title
    end

    def og_description
      @og_description.presence || public_page_description
    end

    # def og_thumbnail
    #   image_url @og_image ? @og_image.url : 'fb-share/fb-share.jpg'
    # end
    #
    # def og_image_width
    #   @og_image.width if @og_image
    # end
    #
    # def og_image_height
    #   @og_image.height if @og_image
    # end

    def og_site_name
      @og_site_name.presence || t('domain.short')
    end

    def og_url
      request.original_url.gsub('http://', 'https://')
    end
  end
end