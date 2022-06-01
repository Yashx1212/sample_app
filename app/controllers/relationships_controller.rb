class RelationshipsController < ApplicationController
    before_action :logged_in_user, only: [ :create , :destroy]

    def create
        @user = User.where(id: params[:followed_id]).first

        unless @user.present?
            flash[:danger] = "User not present"
            redirect_back_or root_url
        else
            current_user.follow(@user)
            respond_to do |format|
                format.html { redirect_to @user }
                format.js
            end
        end
    end

    def destroy
        relationship = Relationship.where(id: params[:id]).first
        unless relationship.present?
            flash[:danger] = "User not present"
            redirect_back_or root_url
        else
            @user = relationship.followed
            current_user.unfollow(@user)
            respond_to do |format|
                format.html { redirect_to @user }
                format.js
            end
        end
    end
end
