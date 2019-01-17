# frozen_string_literal: true

module Folio
  module ImageHelper
    def img_tag_retina(normal, retina, html_options = {})
      html_options[:srcset] = "#{normal} 1x, #{retina} 2x"
      image_tag normal, html_options
    end

    def img_tag_retina_static(path, html_options = {})
      split_path = path.split('.')
      retina_path = split_path.first(split_path.size - 1).join('.') + '@2x.' + split_path.last

      normal = image_path(path)
      retina = image_path(retina_path)

      img_tag_retina normal, retina, html_options
    end

    def dummy_image_url(variant)
      "http://dummyimage.com/#{variant}/FFF/000.png&text=TODO: Vybrat a nahrát v consoli"
    end
  end
end
