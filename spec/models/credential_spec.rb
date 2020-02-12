# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Credential, type: :model do
  let(:token) { 'token' }
  let(:encrypted_token) { 'USdh2113nsakjSFJv=' }
  subject { instance_double('credentials', token: token) }

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

    expect(credential.token).to eq(encrypted_token)
    expect(credential.token_encrypted).to eq(encrypted_token)
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
