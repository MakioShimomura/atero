#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# bundle exec rails db:migrate 普通本番環境ではこちらを使う

# 最終deploy時に削除
bundle exec rails db:migrate:reset
bundle exec rails db:seed