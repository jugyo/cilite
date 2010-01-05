module Tester
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/views"
    set :public, "#{dir}/public"
    set :static, true
    set :lock, true

    get '/' do
      @logs = Log.logs.map {|key| Log[key]}
      haml :index
    end

    get '/css' do
      sass :styles
    end

    get '/logs/:hash' do
      @hash = params[:hash]
      @log = Log[@hash]
      haml :show
    end
  end
end
