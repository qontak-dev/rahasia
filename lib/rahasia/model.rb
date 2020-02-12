# frozen_string_literal: true

module Rahasia
  # Model for ActiveRecord extension
  # https://github.com/ankane/lockbox/blob/80adc597b27172b5e420471db5888b8f962ad829/lib/lockbox/model.rb
  module Model
    def enrcypt_column(*attributes, **options)
      unless [nil, :string].include?(options[:type])
        raise ArgumentError, "UnknownType #{options[:type]}."
      end

      activerecord = defined?(ActiveRecord::Base) && self < ActiveRecord::Base
      if options[:type] && !activerecord
        raise ArgumentError, 'Type not supported yet with Mongoid'
      end

      define_attributes(attributes)
    end

    def define_attributes(attributes)
      attributes.each do |name|
        encrypted_attribute = "#{name}_encrypted"
        decrypt_method_name = "decrypt_#{encrypted_attribute}"

        define_decrypt_method_name(decrypt_method_name)
        define_decrypt(name, encrypted_attribute, decrypt_method_name)
        define_setter(name)
      end
    end

    # ------------------------------------
    # available column refresh_token, name
    # ------------------------------------
    # Credential < ActiveRecord
    #   enrcypt_column :refresh_token
    # end
    #
    #  available method
    #   # decrypt_refresh_token_encrypted
    #   # refresh_token_chipertext?
    #   # refresh_token
    #   # refresh_token=(string)
    #   # refresh_token_encrypted
    #
    # refresh_token_encrypted
    # token_encrypted
    #
    def define_decrypt_method_name(decrypt_method_name)
      define_singleton_method decrypt_method_name do |encrypted, **_opts|
        Rahasia.encryptor.decrypt(
          key: Rahasia.master_key,
          value: encrypted
        )
      end
    end

    # refresh_token
    # token
    def define_decrypt(name, encrypted_attribute, decrypt_method_name)
      define_method(name) do
        message = super()
        unless message
          ciphertext = send(encrypted_attribute)
          message =
            self.class.send(decrypt_method_name, ciphertext, context: self)
        end
        message
      end
    end

    # refresh_token=(string)
    #  # refresh_token_encrypted
    def define_setter(name)
      define_method("#{name}=") do |val|
        encrypted = Rahasia.encryptor.encrypt(
          key: Rahasia.master_key,
          value: val
        )
        send("#{name}_encrypted=", encrypted)
        instance_variable_set("@#{name}", val)
      end
    end
  end
end
