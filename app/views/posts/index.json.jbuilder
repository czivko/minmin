json.array!(@posts) do |post|
  json.extract! post, :title, :body, :slug, :post_type, :publish, :tags
  json.url post_url(post, format: :json)
end
