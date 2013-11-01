require 'sinatra'
require 'active_record'
require_relative './app/models/member'
require_relative './app/models/post'
require_relative './app/sessions.rb'
require  'bcrypt'
require 'pry'

enable :sessions

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'time_fuck')

###Landing Page
get '/' do
  redirect '/users/new'
end

get '/users/new' do
  erb :sign_up
end

post '/sessions' do
  authenticate_user
end

get '/sessions' do
 #how do we save the user session
end

get '/users' do
  erb :sign_in
end

post '/users' do
  add_users
  erb :index
end

###Member Home Page
get '/member' do
  @posts = Post.all
  erb :member
end

###Member Feed
get '/member/feed' do
  @posts = Post.all
end

###Create Post
post '/posts' do
  p params
  Post.create(params)
  redirect '/member/feed'
end

###Search - Redirect with parameters
post '/search' do
  @search_results = Member.where(first_name: params[:search_entry])
  p @search_results
  p 'First @search'
  erb :search
end

# # ###Search Results
# get '/member/search' do
#   # p @search_results = Member.where(first_name: params[:search_entry])
#   p 'Second @search'
#   erb :search_results
# end

###New Member
post '/new_member' do
  Member.create(params)
  redirect '/member/feed'
end