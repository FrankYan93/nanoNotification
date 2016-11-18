get '/noticifiction/:user_id' do





  erb :noticification
end




def control_bar
    @page_user_name = params[:username]
    @x = "location='#{ENV['NANOURL']}/#{@page_user_name}/editProfile'"
    @y = "location='#{ENV['NANOURL']}/#{@page_user_name}/followers'"
    @z = "location='#{ENV['NANOURL']}/#{@page_user_name}/followings'"
    @user_tweets = "location='#{ENV['NANOURL']}/#{@page_user_name}/tweets'"

    if @page_user_name == session[:username]
        erb :my_control_bar
    else
        erb :other_control_bar
    end
end
