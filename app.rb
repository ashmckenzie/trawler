get '/' do
  @q = ''
  @results = []
  erb :index
end

get '/search' do
  @q = params[:q]
  @results = LogEntry.any_of(path: Regexp.new(@q)).desc(:timestamp)
  erb :index
end
