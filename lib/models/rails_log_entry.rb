class RailsLogEntry < LogEntry
  include Mongoid::Document

  field :request_type, type: String
  field :status_code, type: String
  field :time, type: Integer
  field :path, type: String
  field :ip_address, type: String

  index({ path: 1 }, { background: true })
  index({ status_code: 1 }, { background: true })

  def as_string
    "#{status_code} #{request_type} #{ip_address} #{path}"
  end
end
