json.extract! @user, :username
unless @user.valid?
  json.errors do
    json.extract! @errors, :messages
  end

  json.username_suggestions do
    json.array! @username_suggestions, :username
  end
end
