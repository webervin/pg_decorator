# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pg_decorator/version'

Gem::Specification.new do |gem|
  gem.name          = 'pg_decorator'
  gem.version       = PgDecorator::VERSION
  gem.authors       = ['Ervin Weber']
  gem.email         = %w(webervin@gmail.com)
  gem.description   = %q{adds caller method as SQL comment}
  gem.summary       = %q{Makes ruby caller visible in PostgreSQL log}
  gem.homepage      = 'https://github.com/webervin/pg_decorator'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)
  gem.add_runtime_dependency 'pg'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rubocop'
end
