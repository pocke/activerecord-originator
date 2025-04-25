# ActiveRecord::Originator

Add SQL comments to indicate the origin of the SQL.

This gem adds SQL comments indicating the origin of the part of the query. This is useful for debugging large queries.

Rails tells us where the SQL is executed, but it doesn't tell us where the SQL is constructed.
This gem lets you know where the SQL is constructed! For example:

```sql
Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."status" = ? /* app/models/article.rb:3:in `published' */
 AND "articles"."category_id" = ? /* app/controllers/articles_controller.rb:3:in `index' */
 ORDER BY "articles"."created_at" DESC /* app/models/article.rb:4:in `order_by_latest' */
```

You can see where `.where` and `.order` methods are called without reading the source code. It is helpful if the query builder is complex.

## Installation

Install the gem and add to the application's Gemfile by executing:

```console
$ bundle add activerecord-originator
```

You do not need to do anything else. The gem will automatically add comments to the SQL.
Check the logs to see the comments.

### Configure format

You can set `ActiveRecord::Originator.format` to `:one_liner` if you prefer your SQL log in one line.

```ruby
# in your configuration file
ActiveRecord::Originator.format = :one_liner
```

Then you can get logs like below.

```sql
Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."status" = ? /* <- app/models/article.rb:3:in `published' */ AND "articles"."category_id" = ? /* <- app/controllers/articles_controller.rb:3:in `index' */ ORDER BY "articles"."created_at" DESC /* <- app/models/article.rb:4:in `order_by_latest' */
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pocke/activerecord-originator.
