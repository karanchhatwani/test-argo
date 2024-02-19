json.extract! profile, :id, :name, :youtube, :twitter, :other, :created_at, :updated_at
json.url profile_url(profile, format: :json)
