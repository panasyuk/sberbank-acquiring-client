# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sberbank/acquiring'
require 'securerandom'

require 'minitest/autorun'
require 'webmock/minitest'
