require 'net/ldap'
#require 'yaml'
require 'time_diff'
require 'sinatra'
require 'slim'
require 'datamapper'
require_relative 'time_converter'
require_relative 'my_ad'
require_relative 'person'
enable :sessions


#people = Person.from_list(MyAd.old_people)
#puts person

get '/' do
  slim :index
end

post '/login' do
  ldap = Net::LDAP.new
  ldap.host = "172.16.2.12"
  ldap.port = 389
  ldap.auth params[:username], params[:password]
  if ldap.bind && params[:username] != "" && params[:password] != ""
    session[:user] = {username: params[:username], password: params[:password]}
    redirect '/home'
  else
    redirect '/loginFail'
  end
end

post '/logout' do
  session.destroy
  redirect '/'
end

get '/loginFail' do
  slim :loginFail
end

get '/home' do
  if session[:query]
    @search_result = Person.from_list(MyAd.find(session[:query], session[:user]))
  end
  slim :home
end

post '/search' do
  #search_result = Person.new(MyAd.find(params[:search], session[:user]).first)
  session[:query] = params[:search]
  #p session[:query]
  redirect '/home'
end