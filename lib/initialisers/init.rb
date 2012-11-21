require 'bundler/setup'
Bundler.require(:default, :development)

require 'active_support/all'

dir = File.expand_path('../../../lib/models', __FILE__)
Dir["#{dir}/*"].each { |file| require file }

Mongoid.load!(File.expand_path('../../../config/mongoid.yml', __FILE__), :development)
