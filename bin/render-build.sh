#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails tailwindcss:install
bundle exec rails tailwindcss:build
bundle exec rails db:migrate
bundle exec rails assets:clean
bundle exec rails assets:precompile
