require 'bundler/setup'
Bundler.require(:default, :development)

require 'sinatra/base'
require 'sprockets'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require 'active_support/all'

dirs = [
  File.expand_path('../../../lib', __FILE__),
  File.expand_path('../../../lib/support', __FILE__),
  File.expand_path('../../../lib/models', __FILE__)
]

dirs.each do |dir|
  Dir["#{dir}/*.rb"].each { |file| require file }
end

Mongoid.load!(File.expand_path('../../../config/mongoid.yml', __FILE__), :development)
