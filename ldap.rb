require 'net/ldap'
#require 'yaml'
require 'time_diff'
require 'sinatra'
require 'slim'
require_relative 'time_converter'
require_relative 'my_ad'
require_relative 'person'

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
    redirect '/home'
  else
    redirect '/loginFail'
  end
end

get '/loginFail' do
  slim :loginFail
end

get '/home' do
  slim :home
end