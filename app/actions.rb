helpers do

  def current_user
    if session[:id] && session[:id] != "" 
      User.find(session[:id])
    end
  end

  def authorized?
    if !session[:id]
      redirect '/'
    end
  end
end

get '/' do
  redirect '/notes'
end

get '/session/new' do
  erb :'/user_session/new'
end 

post '/session' do
  @user = User.find_by(username: params[:username])
  @username =  params[:username]
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
  @user = User.where(id: params[:id])[0]
  erb :'users/profile'
end


## Notes ##
get '/notes' do
  erb :'notes/index'
end

get '/notes/new' do
  erb :'notes/new'
end

post '/notes' do
  @note = Note.create(user_id: current_user.id, text: params[:text]);
  if params[:text] == ""
    @error_message = "Please write something!"
    erb :'notes/new'
  else current_user.id && @note && params[:text]
    redirect "/users/#{current_user.id}"
  end
end

get '/notes/:id' do
  @note = Note.where(id: params[:id])[0]
  erb :'notes/note'
end

post '/notes/:id/comments' do
  new_comment = Comment.new(user_id: current_user.id, note_id: params[:id], text: params[:text], vote_kind: params[:vote_kind])
  if new_comment.save
    redirect "/notes/#{params[:id]}"
  else
    #must return object
    @note = Note.where(id: params[:id])[0]
    @errors = new_comment.errors
    erb :'notes/note'
  end
end

## Search ##
get '/search' do

end
