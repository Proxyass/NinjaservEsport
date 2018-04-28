class Sponsor < ApplicationRecord
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }

  # Validations
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 2.megabytes
  validates :name, :url, :description, presence: true
  # -----
end
