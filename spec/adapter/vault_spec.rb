# frozen_string_literal: true

RSpec.describe Rahasia::Adapter::Vault do
  context '.vault' do
    subject(:vault) do
      config = Rahasia
      config.adapter = 'vault'
      config.vault_app = 'cubbyhole'
      config.vault = { address: 'http://localhost:8200', ssl_verify: false, token: 's.TaWtwLTczBiwd0w36fMkrO8i' }
      config
    end

    it 'vault adapter' do
      expect(vault.adapter).to be('vault')
    end

    it 'vault encryptor' do
      expect(vault.encryptor).to be(Rahasia::Adapter::Vault)
    end

    it '#encrypt' do
      key = Rahasia.master_key
      value = 'token'
      uuid = SecureRandom.hex(4)
      encrypt = subject.encryptor.encrypt(key: key, value: value, uuid: uuid)
      decrypt = subject.encryptor.decrypt(key: key, value: encrypt, uuid: uuid)

      expect(value).to eq(decrypt)
    end

    it '#decrypt' do
      key = Rahasia.master_key
      value = 'token'
      uuid = SecureRandom.hex(4)
      encrypt = subject.encryptor.encrypt(key: key, value: value, uuid: uuid)
      decrypt = subject.encryptor.decrypt(key: key, value: encrypt, uuid: uuid)

      expect(value).to eq(decrypt)
    end
  end
end
