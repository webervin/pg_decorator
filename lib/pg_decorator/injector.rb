module PgDecorator
  class Injector
    def self.enable(custom_app_name = 'Ruby pg app', custom_app_root = null)
      custom_app_root ||= Dir.pwd
      require 'pg' unless defined?(PG)
      require_relative 'decorator'
      PG::Connection.module_eval do
        define_method(:app_name) { custom_app_name }
        define_method(:app_root) { custom_app_root }
        include PgDecorator::Decorator
      end
      true
    end
    alias_method :inject, :enable
  end
end