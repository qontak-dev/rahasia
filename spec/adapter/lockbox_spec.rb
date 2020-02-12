# frozen_string_literal: true

RSpec.describe Rahasia::Adapter::Lockbox do
  context '.lockbox' do
    subject { Rahasia }

    it 'default adapter' do
      expect(subject.adapter).to be('lockbox')
    end

    it 'default encryptor' do
      expect(subject.encryptor).to be(Rahasia::Adapter::Lockbox)
    end

    it '#encrypt' do
      key = Rahasia.master_key
      value = 'token'
      encrypt = subject.encryptor.encrypt(key: key, value: value)
      decrypt = subject.encryptor.decrypt(key: key, value: encrypt)

      expect(value).to eq(decrypt)
    end

    it '#decrypt' do
      key = Rahasia.master_key
      value = 'token'
      encrypt = subject.encryptor.encrypt(key: key, value: value)
      decrypt = subject.encryptor.decrypt(key: key, value: encrypt)

      expect(value).to eq(decrypt)
    end
  end
end
