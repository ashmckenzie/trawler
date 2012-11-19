class LogEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :raw, type: String

  index 'type' => 1
end
