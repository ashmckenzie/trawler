class NginxLogEntry < LogEntry
  include Mongoid::Document

  field :ip_address, type: String
  field :method, type: String
  field :path, type: String
  field :status_code, type: String

  index({ ip_address: 1 }, { background: true })
  index({ method: 1 }, { background: true })
  index({ path: 1 }, { background: true })
  index({ status_code: 1 }, { background: true })

  def line
    "#{status_code} #{method} #{ip_address} #{path}"
  end

  def extra_summary
    %w{ ip_address }
  end
end
