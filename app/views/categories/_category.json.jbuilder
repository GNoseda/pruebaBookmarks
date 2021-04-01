json.extract! category, :id, :title, :category_id, :is_public, :created_at, :updated_at
json.url category_url(category, format: :json)
