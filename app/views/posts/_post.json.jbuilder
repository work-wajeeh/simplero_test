json.extract! post, :id, :title, :content, :author_id, :group_id, :created_at, :updated_at
json.url group_post_url(post, format: :json)
