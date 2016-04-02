if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end

require 'rubygems'
require 'bundler/setup'
require 'dotpay'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = "random"
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
