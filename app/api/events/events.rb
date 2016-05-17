module Events
    class EventsController < Grape::API
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
      resource :events do
       desc 'add event'
       oauth2
      params do
        requires :location, type: String, desc: 'Lokalizacja'
        requires :describe, type: String , desc: 'opis'
        requires :discount, type: Integer, desc: 'znizka'
        requires :store, type: String, desc: 'sklep'
        end
        post :do_event do
          Event.create!({
               user_id: resource_owner.id,
               location: params[:location],
               describe: params[:describe],
               discount: params[:discount],
               store: params[:store]
               })
        end

        desc 'Delete event'
        oauth2
        params do
         requires :id, type: Integer, desc: 'Id eventu'
        end
        delete :delete do
          Event.find(params[:id]).destroy
        end

        desc 'find event in location'
        oauth2
        params do
          requires :location, type: String, desc: 'Lokalizacja'
        end
        get :find do
          Event.where(location: params[:location])
        end


    desc 'update event'
    oauth2
    params do
      requires :id, type: Integer, desc: 'event_id'
      requires :location, type: String, desc: 'Lokalizacja'
      requires :describe, type: String, desc: 'opis'
      requires :discount, type: Integer, desc: 'znizka'
      requires :store, type: String, desc: 'sklep'
    end
    put :update do
      resource_owner.events.find(params[:id]).update({
        location: params[:location],
        describe: params[:describe],
        discount: params[:discount],
        store: params[:store]
        })
    end


    end
    end
  end

