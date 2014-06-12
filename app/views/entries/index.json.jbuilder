json.array!(@entries) do |entry|
  json.extract! entry, :id, :input, :from, :to, :output
  json.url entry_url(entry, format: :json)
end
