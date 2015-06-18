helpers do
  def current_user
    if session[:id] && session[:id] != "" 
      User.find(session[:id])
    end
  end
end


# Homepage (Root path)
get '/' do
  erb :index
end

## Login ##
get '/session/new' do
  #some code here
  erb :'/user_session/new'
end 

post '/session' do
  @user = User.find_by(username: params[:username])

  if @user && @user.password == params[:password]
    session[:id] = @user.id
    redirect '/notes'
  else
    #error messages
    if params[:username].empty? && params[:password].empty?
      @error_message = "Please fill in your username and password."
    elsif params[:username].empty?
      @error_message = "Please fill in your username."
    elsif !@user 
      @error_message = "Username does not exist."
    elsif @user && @user.password != params[:password]
      @error_message = "Your password is wrong"
    end
  end
  erb :'/user_session/new'
end

delete '/session' do
  #some code here
end

## Users ##
get '/users/:id' do

end


## Notes ##
get '/notes' do
  erb :'notes/index'
end

get '/notes/:id' do

end

get '/notes/new' do

end

post '/notes' do

end

get 'notes/:id/comments/new' do

end

post 'notes/:id/comments' do

end


## Search ##
get '/search' do

end
