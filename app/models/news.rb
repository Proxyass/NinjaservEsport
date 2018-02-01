class News < ApplicationRecord
  # Validation
  validates :title, :content, presence: true
  # -----

  # Relations
  belongs_to :user
  # -----

end
