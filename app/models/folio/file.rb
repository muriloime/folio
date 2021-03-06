# frozen_string_literal: true

class Folio::File < Folio::ApplicationRecord
  include Folio::Filterable
  include Folio::HasHashId
  include Folio::MimeTypeDetection
  include Folio::SanitizeFilename
  include Folio::Taggable

  dragonfly_accessor :file do
    after_assign :sanitize_filename
  end

  # Relations
  has_many :file_placements, class_name: 'Folio::FilePlacement::Base',
                             dependent: :destroy
  has_many :placements, through: :file_placements

  # Validations
  validates :file, :type,
            presence: true

  # Scopes
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_placement, -> (placement_title) { order(created_at: :desc) }
  scope :by_tags, -> (tags) do
    if tags.is_a?(String)
      tagged_with(tags.split(','))
    else
      tagged_with(tags)
    end
  end

  pg_search_scope :by_file_name,
                  against: [:file_name],
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :by_placement,
                  associated_against: {
                    file_placements: [:placement_title],
                  },
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }

  before_save :set_mime_type
  after_save :touch_placements

  def title
    file_name
  end

  def file_extension
    if /msword/.match?(mime_type)
      /docx/.match?(file_name) ? :docx : :doc
    else
      Mime::Type.lookup(mime_type).symbol
    end
  end

  def to_h
    {
      thumb: is_a?(Folio::Image) ? thumb(Folio::Console::FileSerializer::ADMIN_THUMBNAIL_SIZE).url : nil,
      file_size: file_size,
      file_name: file_name,
      type: type,
      id: id,
    }
  end

  def self.hash_id_additional_classes
    [Folio::PrivateAttachment]
  end

  private

    def touch_placements
      file_placements.each(&:touch)
    end

    def set_mime_type
      return unless file.present?
      return unless respond_to?(:mime_type)
      self.mime_type = get_mime_type(file)
    end
end

# == Schema Information
#
# Table name: folio_files
#
#  id              :bigint(8)        not null, primary key
#  file_uid        :string
#  file_name       :string
#  type            :string
#  thumbnail_sizes :text             default("--- {}\n")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  file_width      :integer
#  file_height     :integer
#  file_size       :bigint(8)
#  mime_type       :string(255)
#  additional_data :json
#  file_metadata   :json
#  hash_id         :string
#
# Indexes
#
#  index_folio_files_on_created_at  (created_at)
#  index_folio_files_on_file_name   (file_name)
#  index_folio_files_on_hash_id     (hash_id)
#  index_folio_files_on_type        (type)
#
