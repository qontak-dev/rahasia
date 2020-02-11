# frozen_string_literal: true

require 'rails/generators/base'

#
# Generate file init/rahasia.rb
#
module Rahasia
  module Generators
    # Extend Rails Base Generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(__dir__, '../templates')

      def copy_initializer
        template "rahasia.rb", "config/initializers/rahasia.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end

    end
  end
end
