module Comments
    class CommentsController < Grape::API
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
           error!({ error: e.message }, 404)
         end


        resource :comments do

          desc 'add comment'
          oauth2
          params do
            requires :content, type: String, desc: 'content'
            requires :event_id, type: Integer, desc: 'id_eventu'
            end
           post :do_comment do
             Comment.create!({
               user_id: resource_owner.id,
               content: params[:content],
               event_id: params[:event_id]
               })
            end

              desc 'add comment'
               oauth2
               params do
                requires :id, type: Integer, desc: 'Id eventu'
               end
               delete :delete do
                 Comment.find(params[:id]).destroy
               end

              desc 'find comment'
               oauth2
               params do
                 requires :id, type: Integer, desc: 'Id eventu'
               end
               get :find do
                 Comment.where(event_id: params[:id])
               end

               desc 'update coment'
               oauth2
               params do
                 requires :id, type: Integer, desc: 'comment_id'
                 requires :content, type: String, desc: 'content'
                 requires :event_id, type: Integer, desc: 'id_eventu'
               end
               put :update do
                 resource_owner.comments.find(params[:id]).update({
                   content: params[:content]
                   })
               end

        end
    end
  end
