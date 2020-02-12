# frozen_string_literal: true

# Rahasia::Adapter::Lockbox.encrypt(key: SecureRandom.hex(32), value: 'token')
# Rahasia::Adapter::Lockbox.decrypt(key: SecureRandom.hex(32), value: t)
module Rahasia
  module Adapter
    # Adapter lockbox
    class Lockbox
      def self.encrypt(key:, value:)
        lockbox = ::Lockbox.new(key: key)
        lockbox.encrypt(value)
      end

      def self.decrypt(key:, value:)
        lockbox = ::Lockbox.new(key: key)
        lockbox.decrypt(value)
      end
    end
  end
end
