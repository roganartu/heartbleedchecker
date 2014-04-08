require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './lib/redis_helper'
require './lib/heartbleeder'
require './heartbleedchecker'

ENV['RACK_ENV'] ||= 'production'
set :environment, ENV['RACK_ENV']
set :run, false
set :raise_errors, true

# Yay, easy multithreading
configure { set :server, :puma }

run Sinatra::Application
