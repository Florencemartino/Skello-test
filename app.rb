require "sinatra"
require "sinatra/reloader" if development?
require_relative "database"

get '/' do
    @database = DB
    erb :index
end

not_found do
    'Page not found'
end

get '/new_post' do
    erb :new_post
end

post '/new_post' do
  @database = DB
    post = Hash.new
    post[:title] = params[:title]
    post[:content] = params[:content]
    post[:photo] = params[:photo]
    @database << post
    redirect '/'
end

get '/:title' do
  @database = DB
    @comments = COMMENTS
    @post = @database.find { |post| post[:title] == params[:title]}
    # i = 0
    # p @comments[2]
    @i = @database.find_index { |post| post[:title] == params[:title]}
    @comment = @comments[@i]
    #@comments = COMMENTS[params[:id].to_i]
    erb :show
end

# put '/:title/upvote' do
#   @post = @database.find { |post| post[:title] == params[:title]}
#   post.votes += 1
#   post.save

#   redirect to('/')
# end

