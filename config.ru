require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './heartbleedchecker'

set :environment, :development
set :run, false
set :raise_errors, true

# Yay, easy multithreading
configure { set :server, :puma }

run Sinatra::Application
