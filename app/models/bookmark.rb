class Bookmark < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  
  has_many :bookmark_kinds
  has_many :kinds, through: :bookmark_kinds
  accepts_nested_attributes_for :bookmark_kinds
  
  has_many :bookmark_categories
  has_many :categories, through: :bookmark_categories
  accepts_nested_attributes_for :bookmark_categories

  def get_categories
    formater(self.categories)
  end
 
  def get_kinds
    formater(self.kinds)
  end

  def destroy_dependant
    BookmarkCategory.where(bookmark_id: self.id).each do |x|
      x.update_attribute(:category_id, nil)
      x.delete
    end

    BookmarkKind.where(bookmark_id: self.id).each do |x|
      x.update_attribute(:kind_id, nil)
      x.delete
    end
  end

  def formater(arr)
    line = ""
    first = true
    arr.each do |obs|
      line = line + " " + obs.title
      if first
        if arr.length > 1
          line = line + ","  
        end
        first =  false
      end
    end
    line
  end
end
