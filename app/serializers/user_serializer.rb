class UserSerializer < ActiveModel::Serializer
  attributes :id, :profile_name, :full_name, :email, :gravatar_url

     
end
