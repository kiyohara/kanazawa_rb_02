require "sinatra"
require "sinatra/reloader"

Sinatra.register Sinatra::Reloader

require "dm-core"
require "dm-migrations"

DataMapper.setup(:default, "sqlite3:messages.sqlite3")
class Messages
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :title, String
  property :body, String
  property :date, DateTime
  auto_upgrade!
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  @messages = Messages.all(:order => [:date.desc])
  haml :index
end

post '/post' do
  Messages.create({
    :name => params[:name],
    :title => params[:title],
    :body => params[:body],
    :date => Time.now,
  })
  redirect '/'
end

get '/style.css' do
  sass :style
end

