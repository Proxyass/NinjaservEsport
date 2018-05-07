class News < ApplicationRecord
  # Validation
  validates :title, :content, :beauty_url, presence: true
  validates :beauty_url, uniqueness: true
  # -----

  # Relations
  belongs_to :user
  has_many :news_assets, dependent: :delete_all
  # -----

  # Hooks
  before_save :check_pretty_url
  # -----

  def check_pretty_url
    self.beauty_url = self.beauty_url.parameterize
  end
end
