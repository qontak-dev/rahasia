# frozen_string_literal: true

require 'active_support'

require 'pry'
require 'lockbox'
require 'vault'
require 'encryptor'
require 'adapter/lockbox'
require 'adapter/vault'
require 'rahasia/version'
require 'rahasia/model'

if defined?(ActiveSupport)
  ActiveSupport.on_load(:active_record) do
    extend Rahasia::Model
  end
end

require 'generators/rahasia/migration_generator' if defined?(ActiveRecord)

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
    @encryptor =
      if adapter == 'vault'
        Adapter::Vault
      else
        Adapter::Lockbox
      end
    adapter
  end

  def self.adapter
    @adapter || null_adapter
  end

  # Encryptor
  mattr_accessor :encryptor
  def self.encryptor=(encryptor)
    @encryptor = encryptor
  end

  def self.encryptor
    @encryptor || null_encryptor
  end

  # Vault Setting
  mattr_accessor :vault
  def self.vault=(vault)
    @vault = vault
  end

  def self.vault
    @vault
  end

  def self.null_adapter
    'lockbox'
  end

  def self.null_encryptor
    Adapter::Lockbox
  end
end
