class UserSerializer < ActiveModel::Serializer
  attributes :profile_name, :full_name, :email, :gravatar_url     
end
