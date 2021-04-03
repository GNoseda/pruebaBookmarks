class Kind < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true
    
    has_many :bookmark_kinds
    has_many :bookmarks, through: :bookmark_kinds

    def bookmarks_count
        BookmarkKind.where(kind_id: self.id).count
    end
end
