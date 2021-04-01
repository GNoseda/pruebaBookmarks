class Category < ApplicationRecord
  belongs_to :category, optional: true
  
  validates :title, presence: true
  validates :is_public, presence: true
  validates :title, presence: true
  
end

