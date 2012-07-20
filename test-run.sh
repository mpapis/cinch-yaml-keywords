#!/usr/bin/env bash

gem build cinch-yaml-keywords.gemspec
gem install cinch-yaml-keywords
(
  cd example
  smfbot
)
