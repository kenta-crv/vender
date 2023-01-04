#!/bin/bash
# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

echo "install nokogiri..."
bundle config set force_ruby_platform true

echo "bundle install..."
bundle install -j4 --retry 5

echo "start rails server..."
bundle exec rails s -b '0.0.0.0'
