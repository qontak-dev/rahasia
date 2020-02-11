# frozen_string_literal: true

module Rahasia
  module Model
    # https://github.com/ankane/lockbox/blob/80adc597b27172b5e420471db5888b8f962ad829/lib/lockbox/model.rb
    def enrcypt_column(*attributes, **options)
      activerecord = defined?(ActiveRecord::Base) && self < ActiveRecord::Base
      raise ArgumentError, "Type not supported yet with Mongoid" if options[:type] && !activerecord

      attributes.each do |name|

        encrypted_attribute = "#{name}_encrypted"
        decrypt_method_name = "decrypt_#{encrypted_attribute}"

        define_singleton_method decrypt_method_name do |ciphertext, **opts|
          message = ciphertext.presence || ""
          message.to_s
        end

        define_method(name) do
          message = super()

          unless message
            ciphertext = send(encrypted_attribute)
            message = self.class.send(decrypt_method_name, ciphertext, context: self)
          end

          message
        end

        define_method("#{name}=") do |val|
          instance_variable_set("@#{name}", val)
        end

      end
    end

  end
end
