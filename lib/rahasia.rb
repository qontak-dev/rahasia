# frozen_string_literal: true

require 'active_support'

require 'lockbox'
require 'vault'
require 'rahasia/version'
require 'rahasia/model'
require 'generators/rahasia/migration_generator'

if defined?(ActiveSupport)
  ActiveSupport.on_load(:active_record) do
    extend Rahasia::Model
  end
end
# Wrapper for encrypt and keep our credentials secret
module Rahasia
  def self.setup
    yield self
  end

  # Masterkey
  mattr_accessor :master_key
  def self.master_key=(master_key)
    @master_key = master_key
  end

  def self.master_key
    @master_key
  end

  # Adapter
  mattr_accessor :adapter
  def self.adapter=(adapter)
    @adapter = adapter
  end

  def self.adapter
    @adapter
  end

  # Vault Setting
  mattr_accessor :vault
  def self.vault=(vault)
    @vault = vault
  end

  def self.vault
    @vault
  end
end
