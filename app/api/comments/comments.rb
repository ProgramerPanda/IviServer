module Comments
    class CommentsController < Grape::API
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
           error!({ error: e.message }, 404)
         end

        resource :do_comment do
          oauth2
          params do
            requires :content, type: String, desc: 'content'
            requires :event_id, type: Integer, desc: 'id_eventu'
            end
           post do
             Comment.create!({
               user_id: resource_owner.id,
               content: params[:content],
               event_id: params[:event_id]
               })
            end
          end



             resource :delete_comment do
               oauth2
               params do
                requires :id, type: Integer, desc: 'Id eventu'
               end
               delete ':id' do
                 Comment.find(params[:id]).destroy
               end
             end

             resource :find_comments_for do
               oauth2
               params do
                 requires :id, type: Integer, desc: 'Id eventu'
               end
               get ':id' do
                 Comment.where(event_id: params[:id])
               end
             end
    end
  end
