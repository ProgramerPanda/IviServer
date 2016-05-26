module Events
    class EventsController < Grape::API
        version 'v1', using: :header, vendor: 'some_vendor'
        format :json
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

        resource :events do

          desc 'new event'
          oauth2
          params do
            requires :location, type: String, desc: 'Lokalizacja'
            requires :describe, type: String , desc: 'opis'
            requires :discount, type: Integer, desc: 'znizka'
            requires :store, type: String, desc: 'sklep'
          end
           post 'do_event' do
             Event.create!({
               user_id: resource_owner.id,
               location: params[:location],
               describe: params[:describe],
               discount: params[:discount],
               store: params[:store]
               })
            end


          desc 'delete event'
          oauth2
          params do
            requires :id, type: Integer, desc: 'Id eventu'
          end
            delete 'delete_event/:id' do
              Event.find(params[:id]).destroy
            end


          desc 'find event'
          oauth2
          params do
            requires :location, type: String, desc: 'Lokalizacja'
          end
          get 'find_event/:location' do
            Event.where(location: params[:location])
          end


          desc 'update event'
          oauth2
          params do
            requires :id, type: Integer, desc: 'Id eventu'
            requires :location, type: String, desc: 'Lokalizacja'
            requires :describe, type: String, desc: 'opis'
          end
          put 'update_event' do
            Event.find(params[:id]).update({
            location: params[:location],
            describe: params[:describe]
            })
          end
        end
    end
end


