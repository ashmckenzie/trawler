class NginxLogEntry < LogEntry
  include Mongoid::Document

  field :ip_address, type: String
  field :path, type: String
  field :code, type: Integer

  index 'path' => 1
end
