get '/' do
  @q = ''
  @results = []
  erb :index
end

get '/search' do
  @q = Query.new(params[:q])
  terms = @q.terms
  options = terms.structured.merge({ raw: Regexp.new(terms.loose) })
  ap options
  @results = LogEntry.any_of(options).desc(:timestamp)
  erb :index
end

class Query

  attr_reader :raw

  def initialize raw
    @raw = raw
  end

  def as_string
    # terms.map { |key, value| %Q{#{key}="#{value}"} }.join(' ')
    @raw
  end

  def escaped_string
    CGI.escapeHTML(raw)
  end

  def terms
    result = {}
    raw_tmp = raw.clone

    # look for key="value" patterns
    #
    result[:structured] = raw.scan(/([^=]+)="([^"]+)"/).inject({}) do |hash, item|
      key, value = item
      raw_tmp.gsub!(Regexp.new(%Q{#{key}="#{value}"}), '')
      hash[key.strip] = value.strip
      hash
    end

    # now look for other search queries
    #
    result[:loose] = raw_tmp.strip

    Hashie::Mash.new(result)
  end
end
