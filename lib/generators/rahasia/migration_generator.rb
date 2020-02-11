# frozen_string_literal: true

require 'rails/generators/rails/model/model_generator'
require 'rails/generators/active_record/migration/migration_generator'

#
# Generate Encrypt Column using Rahasia generator
#
module Rahasia
  module Generators
    # Extend Rails Model Generator
    class MigrationGenerator < Rails::Generators::ModelGenerator
      include ActiveRecord::Generators::Migration

      source_root File.join(__dir__, '../templates')

      def copy_migration
        suffix = attributes_names.join('_').first(13).to_s.presence || 'encrypt'
        migration_template \
          'migration.rb.tt',
          "db/migrate/rahasia_#{table_name}#{suffix}.rb",
          migration_version: migration_version
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
