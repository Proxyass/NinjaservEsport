class NewsAsset < ApplicationRecord
  has_attached_file :file

  # Relations
  belongs_to :news
  # -----

  # Validations
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 2.megabytes
  # -----

end
