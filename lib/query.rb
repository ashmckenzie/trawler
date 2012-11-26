class Query

  attr_reader :raw

  def initialize raw
    @raw = raw
  end

  def as_string
    @raw
  end

  def as_hash
    terms.structured.merge({ raw: Regexp.new(terms.loose) })
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
      key, value = item.map { |x| x.strip }
      raw_tmp.gsub!(Regexp.new(%Q{#{key}="#{value}"}), '')

      # Translate source-type="xxx_yyy_zz" into _type="XxxYyyZz"
      #
      case key
        when 'source_type'
          key = '_type'
          value = value.camelize
      end

      hash[key] = value
      hash
    end

    # now look for other search queries
    #
    result[:loose] = raw_tmp.strip

    Hashie::Mash.new(result)
  end
end
