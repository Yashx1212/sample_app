module ApplicationHelper
    def full_title(page_title = '')
        base_title = "WeShare"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end

    @@counter=1;

    def increment_counter
        @@counter +=1
    end
end
