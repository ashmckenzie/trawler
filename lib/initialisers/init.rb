require 'bundler/setup'
Bundler.require(:default, :development)

require 'active_support/all'

Dir['./lib/models/*'].each { |file| require file }

Mongoid.load!("./config/mongoid.yml", :development)
