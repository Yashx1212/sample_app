class SavedpostsController < ApplicationController
    before_action :logged_in_user , only: [:create]
    before_action :correct_user, only: [:create]
    def create
        #user_id bookmarklist_id micropost_id 
        savedpost = Savedpost.where(bookmarklist_id: params[:bookmarklist_id], micropost_id: params[:micropost_id]).last
        @micropost = Micropost.where(id: params[:micropost_id]).first
        
        unless @micropost.present?
            flash[:warning] = "Post doesnot exist"
            redirect_to root_url
        else
            if savedpost.present?
                
                if savedpost.destroy
                    
                    respond_to do |format|
                        format.html {flash[:success] = "Removed from savedpost"
                            redirect_back_or root_url}
                        format.js 
                    end
                else
                    flash[:warning] = "Couldn't remove"
                    redirect_back_or root_url
                end
            else
                savedpost = Savedpost.new(user_id: params[:user_id],bookmarklist_id: params[:bookmarklist_id] , micropost_id: params[:micropost_id])
                if savedpost.save
                    
                    respond_to do |format|
                        format.html {flash[:success] = "Post Saved"
                            redirect_back_or root_url}
                        format.js 
                    end
                else
                    flash[:warning] = "COuldn't Save"
                    redirect_back_or root_url
                end
            end
            bookmarked_posts([@micropost])
            puts(@feed_to_bookmarklist_ids_map)
        end
        #redirect_back_or root_url
    end

    private 
    def correct_user
        @user = User.find(params[:user_id])
        redirect_to root_url unless current_user?(@user)
    end

end
