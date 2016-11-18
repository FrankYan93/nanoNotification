get '/api/v1/users/:owner_id/notifications' do
  Notification.where(owner_id: params["owner_id"]).to_json
end
