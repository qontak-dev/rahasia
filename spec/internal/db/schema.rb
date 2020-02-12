# frozen_string_literal: true

ActiveRecord::Schema.define do
  # Set up any tables you need to exist for your test suite that don't belong
  # in migrations.
  create_table(:credentials, force: true) do |t|
    t.string :token
    t.text :token_encrypted
    t.string :name
    t.timestamps null: false
  end
end
