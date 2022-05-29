class BookmarklistsController < ApplicationController
    before_action :logged_in_user , only: [:create , :destroy]
    before_action :correct_user, only: :destroy

    def create
        @bookmarklist = current_user.bookmarklists.build(bookmarklist_params)
        
        if @bookmarklist.save
            flash[:success] = "List created!"
            redirect_to root_url
        else
            flash[:danger] = "Couldn't create list"
            redirect_to root_url
        end
    end

    def destroy
        @bookmarklist.destroy
        flash[:success] = "List Deleted"
        redirect_to request.referrer || root_url
    end

    private
        def bookmarklist_params
            params.require(:bookmarklist).permit(:name)
        end

        def correct_user
            @bookmarklist = current_user.bookmarklists.find_by(id: params[:id])
            redirect_to root_url if @bookmarklist.nil?
        end
end
