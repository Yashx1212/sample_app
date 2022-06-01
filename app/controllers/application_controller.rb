class ApplicationController < ActionController::Base
    include SessionsHelper


    private
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end

        def bookmarked_posts(feed_items)
            @feed_to_bookmarklist_ids_map = Hash.new([])
      
            feed_items.each do |item| 
                @feed_to_bookmarklist_ids_map[item.id] = item.bookmarklists.pluck(:id)
            end
        end 
end
