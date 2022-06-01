class BookmarklistsController < ApplicationController
    before_action :logged_in_user , only: [:create , :destroy , :savedposts]
    before_action :correct_user, only: [:destroy ,:savedposts]

    def create
        @bookmarklist = current_user.bookmarklists.build(bookmarklist_params)
        store_location
        if @bookmarklist.save
            flash[:success] = @bookmarklist.name + "created!"
            respond_to do |format|
                format.html {redirect_to request.referrer || root_url}
                format.js 
            end

        else
            flash[:danger] = "Couldn't create list"
            redirect_to root_url
        end
    end

    def destroy
        if @bookmarklist.destroy
            flash[:success] = "List Deleted"
            respond_to do |format|
                format.html {redirect_to request.referrer || root_url}
                format.js 
            end
        else 
            flash[:danger] = "Couldn't delete list"
            redirect_to root_url
        end
    end

    def savedposts
        @bookmarklist = Bookmarklist.where(id: params[:bookmarklist_id]).last
        
        if @bookmarklist.present?
            @savedposts = @bookmarklist.savedposts
            bookmarked_posts(@bookmarklist.microposts)
            store_location
        else
            flash[:danger] = "Bookmarklist doesn't exist"
            redirect_to root_url
        end
    end

    private
        def savedpost_params
            params.permit(:user_id , :bookmarklist_id)
        end

        def bookmarklist_params
            params.require(:bookmarklist).permit(:name)
        end

        def correct_user
            @bookmarklist = current_user.bookmarklists.find_by(id: params[:id])
            if @bookmarklist.nil?
                flash[:warning] = "Bookmarklist doesnot exist"
                redirect_to root_url 
            end
        end

        def current_list
            @current_list = bookmarklist.find(params[:id])
        end
end
