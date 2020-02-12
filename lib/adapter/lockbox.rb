# frozen_string_literal: true

module Rahasia
  module Adapter
    # Adapter lockbox
    class Lockbox
      def self.encrypt(key:, value:); end

      def self.decrypt(key:, value:); end
    end
  end
end
