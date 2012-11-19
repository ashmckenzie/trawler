class RailsLogEntry < LogEntry
  include Mongoid::Document

  field :request_type, type: String
  field :status_code, type: Integer
  field :time, type: Integer
  field :path, type: String
  field :ip_address, type: String

  def to_s
    "#{status_code} #{request_type} #{ip_address} #{path}"
  end
end
