class NginxLogEntry < LogEntry
  include Mongoid::Document

  field :ip_address, type: String
  field :method, type: String
  field :path, type: String
  field :status_code, type: String

  index({ method: 1 }, { background: true })
  index({ path: 1 }, { background: true })
  index({ status_code: 1 }, { background: true })

  def as_string
    "#{status_code} #{method} #{ip_address} #{path}"
  end
end
