ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# ここで「標準のLogger」をRailsより先に確定させます
require 'logger'

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
