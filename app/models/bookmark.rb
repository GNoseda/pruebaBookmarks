class Bookmark < ApplicationRecord
  belongs_to :category
  belongs_to :kind

  validates :title, presence: true
  validates :url, presence: true
  
end
