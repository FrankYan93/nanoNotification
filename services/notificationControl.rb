def control_bar
    @page_user_name = params[:username]
    @x = "location='/#{@page_user_name}/editProfile'"
    @y = "location='/#{@page_user_name}/followers'"
    @z = "location='/#{@page_user_name}/followings'"
    @user_tweets = "location='/#{@page_user_name}/tweets'"

    if @page_user_name == session[:username]
        erb :my_control_bar
    else
        erb :other_control_bar
    end
end
