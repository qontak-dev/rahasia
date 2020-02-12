# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Credential, type: :model do
  describe '.lockbox' do
    before do
      config = Rahasia
      config.adapter = 'lockbox'
      config
    end

    let(:encrypted_token) { '7GifGwD7+Ls23FX8jyvt5JLWySPGd3300axNycG7jah/' }
    subject { instance_double('credentials', token: 'token') }

    it '#token_encrypted' do
      allow(subject).to receive(:token_encrypted) { encrypted_token }

      expect(subject.token_encrypted).to eq(encrypted_token)
    end

    it '#token' do
      allow(subject).to receive(:token) { encrypted_token }

      expect(subject.token).to eq(encrypted_token)
    end

    it '#token=' do
      credential = Credential.create(token: 'token')
      credential.token = 'token2'
      credential.save

      expect(credential.token).to eq('token2')
    end

    it '#token_chipertext?' do
      allow(subject).to receive(:"token_chipertext?") { true }

      expect(subject.token_chipertext?).to eq(true)
    end

    it '#name_chipertext?' do
      allow(subject).to receive(:"name_chipertext?") { false }

      expect(subject.name_chipertext?).to eq(false)
    end
  end
end
