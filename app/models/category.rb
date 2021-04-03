class Category < ApplicationRecord
  belongs_to :category, optional: true

  validates :title, presence: true
  validates :is_public, presence: true

  has_many :bookmark_categories
  has_many :bookmarks, through: :bookmark_categories

  def get_subcategories(subcategories = [])
    subcagegories ||= []
    subcats = Category.where(category_id: self.id)
    subcats.each do |sc|
      subcategories << sc
      sc.get_subcategories(subcategories)
    end
    subcategories
  end


  def get_sc_titles()
    names = []
    self.get_subcategories.each do |x|
      names << {x.id => x.title} 
    end
    names
  end
  
  def get_bookmarks()
    bookmarks = []
    self.bookmarks.each do |x|
      bookmarks << {x.title => x.url}
    end
    bookmarks
  end
  
  #Done
  def change_public()
    self.update_attribute(:is_public, !self.is_public)
    self.get_subcategories.each do |x|
      x.update_attribute(:is_public, self.is_public)
    end
  end

  def parent
    if not self.category_id.nil?
      line = Category.find(self.category_id).title
    end
  end

  def public_status
    if self.is_public
      line = "Public"
    else
      line = "Private"
    end
  end

  def bookmark_count
    BookmarkCategory.where(category_id: self.id).count
  end

  def subcategories
    formater(self.get_subcategories)
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

