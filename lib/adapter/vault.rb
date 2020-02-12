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
      def self.encrypt(key:, value:, uuid: nil)
        client = ::Vault::Client.new(Rahasia.vault)
        vault = client.kv(Rahasia.vault_app)
        begin
          Vault.sys.mount(
            Rahasia.vault_app, 'kv', 'v2 KV',
            options: { version: '2' }
          )
        rescue StandardError
          print "\nVault mounted!\n"
        end
        uuid = uuid.presence || SecureRandom.hex(4)
        vault.write(uuid, name: value)
      end

      def self.decrypt(key:, value:, uuid: nil)
        client = ::Vault::Client.new(Rahasia.vault)
        vault = client.kv(Rahasia.vault_app)
        begin
          Vault.sys.mount(
            Rahasia.vault_app, 'kv', 'v2 KV',
            options: { version: '2' }
          )
        rescue StandardError
          print "\nVault mounted!\n"
        end
        uuid = uuid.presence || SecureRandom.hex(4)
        vault.read(uuid).data[:name]
      end
    end
  end
end
