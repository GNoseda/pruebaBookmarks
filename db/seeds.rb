# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Category.destroy_all
Kind.destroy_all
Bookmark.destroy_all

created = 0
20.times do
    Category.create(
        title: names.sample,
        url: Faker::Internet.domain_name,
        price: rand(1990..5490),
        origin: origins.sample
    )
    created = created + 1
end

20.times do
    Kind.create(
        title: names.sample,
        url: Faker::Date.between('2020-01-01','2021-03-31'),
        price: rand(1990..5490),
        origin: origins.sample
    )
end

20.times do
    Bookmark.create(
        title: names.sample,
        url: Faker::Date.between('2020-01-01','2021-03-31'),
        price: rand(1990..5490),
        origin: origins.sample
    )
end