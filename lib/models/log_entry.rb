class LogEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :raw, type: String

  index({ type: 1 }, { background: true })

  def source_type
    self.class.to_s.underscore
  end
end
