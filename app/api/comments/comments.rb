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


        resource :comments do

        desc 'create new event'
         oauth2
         params do
           requires :content, type: String, desc: 'content'
           requires :event_id, type: Integer, desc: 'id_eventu'
         end
         post 'do_comment' do
         Comment.create!({
            user_id: resource_owner.id,
            content: params[:content],
            event_id: params[:event_id]
            })
         end


          desc 'delete comment'
           oauth2
            params do
              #requires :id, type: Integer, desc: 'Id eventu'
            end
            delete 'delete_comment/:id' do
              Comment.find(params[:id]).destroy
            end


          desc 'find comment'
           oauth2
           params do
             #requires :id, type: Integer, desc: 'Id eventu'
           end
           get 'find_comments_for/:id' do
             Comment.where(event_id: params[:id])
           end


          desc 'update comment'
          oauth2
          params do
           requires :id, type: Integer, desc: 'id'
           requires :content, type: String, desc: 'content'
           end
           put 'update_comment' do
             Comment.find(params[:id]).update({
              content: params[:content]
              })
           end
        end
    end
  end
