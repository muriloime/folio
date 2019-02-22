# frozen_string_literal: true

class Folio::Image < Folio::File
  include Folio::DragonflyFormatValidation
  include Folio::Thumbnails

  validate_file_format
end

# == Schema Information
#
# Table name: folio_files
#
#  id              :bigint(8)        not null, primary key
#  file_uid        :string
#  file_name       :string
#  type            :string
#  thumbnail_sizes :text             default({})
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  file_width      :integer
#  file_height     :integer
#  file_size       :bigint(8)
#  mime_type       :string(255)
#  additional_data :json
#
# Indexes
#
#  index_folio_files_on_type  (type)
#
