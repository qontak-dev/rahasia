# frozen_string_literal: true

module Rahasia
  module Adapter
    # Adapter vault
    class Vault
      def self.encrypt(key:, value:, uuid: nil)
        # Vault.configure = Rahasia.vault
        # $vault = Vault.kv(Rahasia.vault_app)
        # Vault.sys.mount(
        # Rahasia.vault_app, "kv", "v2 KV",
        # options: { version: "2" }
        # ) rescue print "\nVault mounted!\n"
        # $vault.write("users_#{key}", name: value)
      end

      def self.decrypt(key:, value:, uuid: nil)
        # Vault.configure = Rahasia.vault
        # $vault = Vault.kv(Rahasia.vault_app)
        # $vault.read("users_#{key}")
      end
    end
  end
end
