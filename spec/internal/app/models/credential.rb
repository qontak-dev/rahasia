# frozen_string_literal: true

class Credential < ActiveRecord::Base
  include Rahasia
  enrcypt_column :token, :string
end
