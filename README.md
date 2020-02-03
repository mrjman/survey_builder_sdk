# SurveyBuilderSdk

Provides a library for connection to the Survey Builder API. Exposes a low level client api and high level resources.

To experiment with that code, run `bin/console` for an interactive prompt.

To run with dotenv support

Install the dotenv gem:

```ruby
gem 'dotenv'
```

Create a `.env` file with your values:

    $ cp .env.template .env

And then execute:

    $ dotenv bin/console

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'survey_builder_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install survey_builder_sdk

## Usage

### Environment Variables
By default the gem will look for the following environment variables:
```
SURVEY_BUILDER_API_ACCESS_ID
SURVEY_BUILDER_API_SECRET
SURVEY_BUILDER_API_URL
```

You can add these to your environment manually or with a library (ex. dotenv)

### Low level API

To get started create an api client and make a request:

```
# uses environment variables
client = SurveyBuilder::ApiClient.new

# explicit
client = SurveyBuilder::ApiClient.new(access_id: 'access_id', secret: 'secret', url: 'url')

# make api calls
client.surveys.list_surveys
client.participants.list_participants
```

### Resources

Higher level resources allow for more idiomatic access to the api as well as lazy loading and batching.

```
# internally creates api client based on env params
resource = SurveyBuilder::Resource.new

# explicit
client = SurveyBuilder::ApiClient.new(access_id: 'access_id', secret: 'secret', url: 'url')
resource = SurveyBuilder::Resource.new(client: client)

# retrieve surveys
resource.surveys
resource.surveys.map { |survey| survey.title }
resource.survey('uuid-value')

# retrieve participants
resource.participants
resource.participant('uuid-value')

# retrieve answer sets
resource.participant('uuid-value').answer_sets
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/survey_builder_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SurveyBuilderSdk project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/survey_builder_sdk/blob/master/CODE_OF_CONDUCT.md).
