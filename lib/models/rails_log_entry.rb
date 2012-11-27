class RailsLogEntry < LogEntry
  include Mongoid::Document

  field :method, type: String
  field :status_code, type: String
  field :time, type: Integer
  field :path, type: String
  field :ip_address, type: String

  index({ method: 1 }, { background: true })
  index({ status_code: 1 }, { background: true })
  index({ path: 1 }, { background: true })
  index({ ip_address: 1 }, { background: true })

  def line
    "#{status_code} #{method} #{ip_address} #{path}"
  end

  def extra_summary
    %w{ ip_address }
  end
end
