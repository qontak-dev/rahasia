# frozen_string_literal: true

require 'active_support'

require 'lockbox'
require 'vault'
require 'rahasia/version'
require 'generators/rahasia/migration_generator'

# Wrapper for encrypt and keep our credentials secret
module Rahasia
  def self.setup
    yield self
  end

  # Masterkey
  mattr_accessor :master_key
  @@master_key = nil

  # Adapter
  mattr_accessor :adapter
  @@adapter = nil

  # Vault Setting
  mattr_accessor :vault
  @@vault = nil
end
