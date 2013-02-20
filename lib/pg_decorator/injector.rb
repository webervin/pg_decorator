module PgDecorator
  class Injector
    def self.inject(custom_app_name='Ruby pg app')
      require 'pg' unless defined?( PG )
      require_relative 'decorator'
      PG::Connection.module_eval do
        define_method(:app_name) { custom_app_name }
        include PgDecorator::Decorator
      end
      true
    end
  end
end