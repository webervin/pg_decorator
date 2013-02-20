# PgDecorator

This gem is inspired by [marginalia by 37signals](https://github.com/37signals/marginalia) but instead of patching
Rails, patches [Pg gem](https://bitbucket.org/ged/ruby-pg/wiki/Home)

PgDecorator adds first line of caller (tries to detect place in *your* code by ignoring gems, ruby and rbenv lines) as
/* SQL comment */ so you could later identify "strange" or long queries in your PostgreSQL log directly.

Several reasons for creating gem:

 * marginalia did not decorate some of PostgreSQL adapter queries
 * no Rails 'dependency', you can use this gem if you use pg gem directly, or if you have non rails wrapper, such as [pg_helper](https://github.com/webervin/pg_helper)
 * having aggressive connection pooler in front of database server may lead to loss of "set application_name = 'newappname';",

## Installation

Add this line to your application's Gemfile:

    gem 'pg_decorator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pg_decorator

## Usage

in your ruby script add following:

     require 'rubygems'
     require 'pg_decorator'
     PgDecorator::Injector.inject('AppToRuleWorld')

If you use Rails then you could create config/initializers/pg_decorator

     PgDecorator::Injector.inject('AppToRuleWorld')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
