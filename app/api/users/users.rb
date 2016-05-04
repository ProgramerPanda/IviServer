module Users
	class UsersController < Grape::API
		version 'v1', using: :path
		format :json
		formatter :json, Grape::Formatter::ActiveModelSerializers
		use ::WineBouncer::OAuth2

		default_error_status 400

		rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
			error!({ error: e.message }, 401)
		end

		 rescue_from ActiveRecord::RecordNotFound do |e|
		 	error!({ error: e.message }, 404)
		 end

		 rescue_from ActiveRecord::RecordInvalid do |e|
			 error!({error: e.message }, 404)
		 end

		resource :users do

			desc 'Get infromation about resource owner'
			oauth2
			get :me, root: false, serializer: UserShortSerializer do
				resource_owner
			end

			desc 'Createing new user'
			params do
				requires :first_name, type: String, desc: 'First name'
				requires :last_name, type: String, desc: 'Last name'
				requires :profile_name, type: String, desc: 'Profile name'
				requires :email , type: String, desc: 'Email adress'
				requires :password, type: String, desc: 'Password'
				requires :password_confirmation , type: String, desc: 'Password confirmation'
			end
			post :sign_up do
				User.create!(params)
			end


			desc 'Get user by username'
			params do
				requires :username, type: String, desc: 'Username'
			end
			get ':username', proot: false, serializer: UserShortSerializer do
				User.find_by(profile_name: params[:username])
			end

			resource :id do
				desc 'Get user by id'
				params do
					requires :id, type: Integer, desc: 'user id'
				end
				get ':id', root: false, serializer: UserShortSerializer do
					User.find(params[:id])
				end
			end





		end
	end
end
