module PgDecorator
  class Injector
    def self.inject(custom_app_name='Ruby pg app', custom_app_root=null)
      custom_app_root ||= Dir.pwd
      require 'pg' unless defined?( PG )
      require_relative 'decorator'
      PG::Connection.module_eval do
        define_method(:app_name) { custom_app_name }
        define_meetod(:app_root) { custom_app_root}
        include PgDecorator::Decorator
      end
      true
    end
  end
end