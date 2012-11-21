class NginxLogEntry < LogEntry
  include Mongoid::Document

  field :ip_address, type: String
  field :path, type: String
  field :status_code, type: String

  index 'path' => 1
  index 'status_code' => 1

  def as_string
    "#{status_code} #{request_type} #{ip_address} #{path}"
  end
end
