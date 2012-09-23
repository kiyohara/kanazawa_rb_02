require "sinatra"
require "sinatra/reloader"

Sinatra.register Sinatra::Reloader

get '/' do
  "Hello world !!"
end

get '/:who' do
  escape_html "Hello #{params[:who]}"
end

