# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Credential, type: :model do
  let(:token) { 'token' }
  let(:encrypted_token) { 'USdh2113nsakjSFJv=' }

  it '#token_encrypted' do
    credential = instance_double('credentials', token: token)

    allow(credential).to receive(:token_encrypted) { encrypted_token }
  end

  it '#token' do
    credential = instance_double('credentials', token: token)

    allow(credential).to receive(:token) { nil }
  end

  it '#token=' do
    credential = Credential.new(token: 'token')
    credential.save

    credential.token = 'token2'
    credential.save

    expect(credential.token).to eq(token)
    expect(credential.token_encrypted).to eq(encrypted_token)
  end

  it '#token_chipertext?' do
    credential = instance_double('credentials', token: token)

    allow(credential).to receive(:"token_chipertext?") { true }
  end

end
