# frozen_string_literal: true

module Rahasia
  module Adapter
    # Adapter lockbox
    class Lockbox
      def self.encrypt(key:, value:, uuid: nil)
        lockbox = ::Lockbox.new(key: key)
        string = lockbox.encrypt(value)
        Base64.strict_encode64(string)
      end

      def self.decrypt(key:, value:, uuid: nil)
        lockbox = ::Lockbox.new(key: key)
        chipertext = Base64.decode64(value)
        lockbox.decrypt(chipertext)
      end
    end
  end
end
