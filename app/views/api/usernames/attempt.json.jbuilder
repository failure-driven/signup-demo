json.extract! @user, :username
if @not_valid
  json.errors do
    json.extract! @errors, :messages
  end

  json.username_suggestions do
    json.array! @username_suggestions, :username
  end
end
