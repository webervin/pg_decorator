module PgDecorator
  module Decorator

    IGNORE_LINES_REGEXP = /\.?(rvm|gem|vendor|rbenv|pg_decorator)/

    def self.included(instrumented_class)
      instrumented_class.class_eval do
        alias_method :initialize_without_sql_decorator, :initialize
        alias_method :initialize, :initialize_with_sql_decorator

        alias_method :async_exec_without_sql_decorator, :async_exec
        alias_method :async_exec, :async_exec_with_sql_decorator

        alias_method :async_query_without_sql_decorator, :async_query
        alias_method :async_query, :async_query_with_sql_decorator

        alias_method :exec_without_sql_decorator, :exec
        alias_method :exec, :exec_with_sql_decorator

        alias_method :query_without_sql_decorator, :query
        alias_method :query, :query_with_sql_decorator

        alias_method :prepare_without_sql_decorator, :prepare
        alias_method :prepare, :prepare_with_sql_decorator

        alias_method :send_prepare_without_sql_decorator, :send_prepare
        alias_method :send_prepare, :send_prepare_with_sql_decorator

        alias_method :send_query_without_sql_decorator, :send_query
        alias_method :send_query, :send_query_with_sql_decorator
      end
    end

    def decorate_sql(sql)
      last_line = caller.find { |l| l !~  IGNORE_LINES_REGEXP }
      if last_line
        if last_line.start_with? app_root
          last_line = last_line[app_root.length..-1]
        end
        "/* #{ escape_string(app_name) } #{escape_comment(last_line)} */\n" +
          "#{sql}"
      else
        "/* #{ escape_string(app_name) } outside code tree */\n#{sql}"
      end
    end

    def escape_comment(str)
      escape_string(str.gsub('*/', '* /'))
    end

    def initialize_with_sql_decorator(*args, &block)
      initialize_without_sql_decorator(*args, &block)
      exec_without_sql_decorator(
        "set application_name = '#{escape_string(self.app_name)}';") { true }
      self
    end

    def async_exec_with_sql_decorator(sql, *args, &block)
      async_exec_without_sql_decorator(decorate_sql(sql), *args, &block)
    end

    def exec_with_sql_decorator(sql, *args, &block)
      exec_without_sql_decorator(decorate_sql(sql), *args, &block)
    end

    def query_with_sql_decorator(sql, *args, &block)
      query_without_sql_decorator(decorate_sql(sql), *args, &block)
    end

    def async_query_with_sql_decorator(sql, *args, &block)
      async_query_without_sql_decorator(decorate_sql(sql), *args, &block)
    end

    def prepare_with_sql_decorator(stmt_name, sql, *args, &block)
      prepare_without_sql_decorator(stmt_name, decorate_sql(sql),
                                    *args, &block)
    end

    def send_prepare_with_sql_decorator(stmt_name, sql, *args, &block)
      send_prepare_without_sql_decorator(stmt_name, decorate_sql(sql),
                                         *args, &block)
    end

    def send_query_with_sql_decorator(sql, *args, &block)
      send_query_without_sql_decorator(decorate_sql(sql), *args, &block)
    end

  end
end