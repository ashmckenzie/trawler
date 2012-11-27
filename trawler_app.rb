class TrawlerApp < Sinatra::Base

  include WillPaginate::Sinatra::Helpers

  configure :development do
    register Sinatra::Reloader
    Dir[File.join(File.expand_path('../lib', __FILE__), '**', '*.rb')].each do |file|
      also_reload file
    end
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
    # http://localhost:4567/search?q=status_code%3D%22200%22+Pegasus%3A+%5B1-9%5D%5Cd%7B3%7D
    q = Query.new(params[:q])
    terms = q.terms
    if raw_key = terms.commands['sort']
      key, direction = raw_key.split(/\s*:\s*/)
      sort_by = { key => direction ? direction : -1 }
    else
      sort_by = { timestamp: -1 }
    end
    @results = LogEntry.or(q.as_hash).sort(sort_by).entries.paginate(per_page: 30, :page => params[:page])
    @query = q.escaped_string
    erb :search
  end
end
