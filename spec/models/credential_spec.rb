require 'spec_helper'

RSpec.describe Credential, :type => :model do
  let(:token) { 'token' }
  let(:encrypted_token) { 'USdh2113nsakjSFJv=' }

  it '#token_encrypted' do
    token = instance_double('credentials', token: token)

    allow(token).to receive(:token_encrypted){ encrypted_token }
  end
end
