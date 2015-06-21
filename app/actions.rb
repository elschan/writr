helpers do

  def current_user
    if session[:id] && session[:id] != "" 
      User.find(session[:id])
    end
  end
  
end

# before do
#   if request.path == '/notes/new' && !current_user
#   redirect '/' 
#   end
# end

get '/' do
  redirect '/notes'
end

get '/session/new' do
  erb :'/user_session/new'
end 

post '/session' do
  @user = User.find_by(username: params[:username])
  @username = params[:username]
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
    erb :'/user_session/new'
  end
end

delete '/session' do
  session[:id] = ""
  redirect '/'
end

## Users ##
get '/users/:id' do
  @user = User.find(params[:id])
  @notes = @user.notes.order(created_at: :desc)
  erb :'users/profile'
end

post '/users/newfollow' do
  new_follow = current_user.follow_user(params[:user_id_to_follow].to_i)
  @errors = new_follow.errors
  redirect "/users/#{params[:user_id_to_follow]}"
end

post '/users/unfollow' do
  current_user.unfollow_user(params[:user_id_to_unfollow].to_i)
  redirect "/users/#{params[:user_id_to_unfollow]}"
end


## Notes ##
get '/notes' do
  @notes = Note.all.order(created_at: :desc)
  erb :'notes/index'
end

get '/notes/new' do
  erb :'notes/new'
end

post '/notes' do
  if params[:text].empty?
    @error_message = "Please write something!"
    erb :'notes/new'
  else
    @note = Note.create(user_id: current_user.id, text: params[:text])
    redirect "/notes/#{@note.id}"
  end
end

get '/notes/:id' do
  @note = Note.find(params[:id])
  erb :'notes/note'
end

post '/notes/:id/comments' do
  new_comment = Comment.new(user_id: current_user.id, note_id: params[:id], text: params[:text])
  new_comment.vote_kind = params[:vote_kind] if params[:vote_kind]
  if new_comment.save
    redirect "/notes/#{params[:id]}"
  else
    #must return object
    @note = Note.find(params[:id])
    @errors = new_comment.errors
    erb :'notes/note'
  end
end

## Search ##
get '/search' do
  erb :'search/index'
end

get '/search/results' do

end


