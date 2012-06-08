module CiLite
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,         "#{dir}/views"
    set :public_folder, "#{dir}/public"
    set :static, true

    get '/' do
      @logs = Log.logs.reverse[0..10].map {|key| Log[key]}
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
