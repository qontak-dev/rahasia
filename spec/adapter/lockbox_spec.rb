# frozen_string_literal: true

RSpec.describe Rahasia::Adapter::Lockbox do
  context '.lockbox' do
    subject(:lockbox) do
      config = Rahasia
      config.adapter = 'lockbox'
      config
    end

    it 'default adapter' do
      expect(lockbox.adapter).to be('lockbox')
    end

    it 'default encryptor' do
      expect(lockbox.encryptor).to be(Rahasia::Adapter::Lockbox)
    end

    it '#encrypt' do
      key = lockbox.master_key
      encrypt = lockbox.encryptor.encrypt(key: key, value: 'token')
      decrypt = lockbox.encryptor.decrypt(key: key, value: encrypt)

      expect(decrypt).to eq('token')
    end

    it '#decrypt' do
      key = lockbox.master_key
      encrypt = lockbox.encryptor.encrypt(key: key, value: 'token')
      decrypt = lockbox.encryptor.decrypt(key: key, value: encrypt)

      expect(decrypt).to eq('token')
    end
  end
end
