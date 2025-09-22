json.extract! context, :id, :title, :files, :created_at, :updated_at
json.url context_url(context, format: :json)
json.files do
  json.array!(context.files) do |file|
    json.id file.id
    json.url url_for(file)
  end
end
