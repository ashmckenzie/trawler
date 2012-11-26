class TrawlerApp < Sinatra::Base

  include WillPaginate::Sinatra::Helpers

  configure :development do
    register Sinatra::Reloader
  end

  set :views, File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'

  use SprocketsMiddleware, %r{/assets} do |env|
    env.append_path "assets/stylesheets"
    env.append_path "assets/javascripts"
    env.append_path "assets/images"
    env.append_path "assets/fonts"
  end

  get '/' do
    erb :index
  end

  get '/search' do
    q = Query.new(params[:q])
    terms = q.terms
    @results = LogEntry.any_of(q.as_hash).desc(:timestamp).paginate(per_page: 30, :page => params[:page])
    @query = q.escaped_string
    erb :search
  end
end
