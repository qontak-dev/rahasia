# frozen_string_literal: true

# You may need to set the following environment variable:

#     $ export VAULT_ADDR='http://127.0.0.1:8200'

# The unseal key and root token are displayed below in case you want to
# seal/unseal the Vault or re-authenticate.

# Unseal Key: Rq8uhQeS7BgyMd/T3AeDA9wWGk9XHIlejTgZCSu8ug8=
# Root Token: s.TaWtwLTczBiwd0w36fMkrO8i

module Rahasia
  module Adapter
    # Adapter vault
    class Vault
      def self.encrypt(key:, value:)
        unless ::Vault::Transit.sys.mounts.key? :transit
          ::Vault::Transit.sys.mount('transit', :transit)
        end
        ::Vault::Transit.logical.write("transit/keys/#{key}")
        ::Vault::Transit.enabled = true
        ::Vault::Transit.encrypt(key, value)
      end

      def self.decrypt(key:, value:)
        unless ::Vault::Transit.sys.mounts.key? :transit
          ::Vault::Transit.sys.mount('transit', :transit)
        end
        ::Vault::Transit.logical.write("transit/keys/#{key}")
        ::Vault::Transit.enabled = true
        ::Vault::Transit.decrypt(key, value)
      end
    end
  end
end
