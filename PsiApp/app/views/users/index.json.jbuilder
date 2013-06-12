json.rows do
  json.array!(@users) do |user|
    json.extract! user, :id, :name, :email, :login, :scholarship, :matriculation, :shift_work, :active, :role
    json.url user_url(user, format: :json)
  end
end