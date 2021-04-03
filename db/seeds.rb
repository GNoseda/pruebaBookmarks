# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

BookmarkCategory.destroy_all
BookmarkKind.destroy_all
Bookmark.destroy_all
#Category.destroy_all
Kind.destroy_all


#2.times do
#    Category.create!(
#        title: Faker::Commerce.department,
#        is_public: true
#    )
#end

#8.times do
#   Category.create!(
#       title: Faker::Commerce.department,
#        is_public: true,
#        category_id: Category.all.sample.id
#    )
#end

10.times do
   Kind.create(
        title: Faker::Hipster.word
   )
end

categories = Category.all
kinds = Kind.all

50.times do
    Bookmark.create!(
        title: Faker::Internet.domain_word,
        url: Faker::Internet.domain_name,
    )
end
bookmarks = Bookmark.all

bookmarks.each do |bk|
    cats = rand(1..5)
    cats.times do
        BookmarkCategory.create!(bookmark_id: bk.id, category_id: categories.sample.id)
    end
    knd = rand(1..5)
    knd.times do
        BookmarkKind.create!(bookmark_id: bk.id, kind_id: kinds.sample.id)
    end
end
