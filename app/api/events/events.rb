module Events
  class EventsController < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    use ::WineBouncer::OAuth2

    default_error_status 400
#:user_id, :location, :describe, :discount, :store
    helpers do
   			# Find the user that owns the access token
     			def current_resource_owner
       			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
     			end
    		end

    rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
  			error!({ error: e.message }, 401)
  		end

  		 rescue_from ActiveRecord::RecordNotFound do |e|
  		 	error!({ error: e.message }, 404)
  		 end

       resource :add do
         oauth2
         params do
           requires :location, type: String, desc: 'Lokalizacja'
           requires :describe, type: String , desc: 'opis'
           requires :discount, type: Integer, desc: 'znizka'
           requires :store, type: String, desc: 'sklep'
           end
           post do
             Event.create!({
               user_id: resource_owner.id,
               location: params[:location],
               describe: params[:describe],
               discount: params[:discount],
               store: params[:store]
               })
           end
       end

       resource :remove do
         oauth2
         params do
           requires :id, type: Integer, desc: 'Id eventu'
         end
        delete ':id' do
          Event.find(params[:id]).destroy
        end
       end

       resource :find do
         oauth2
         params do
           requires :location, type: String, desc: 'Lokalizacja'
         end
         get ':location' do
           Event.where(params[:location])
         end
       end



     end
   end
