# Giphy API

Giphy API gem allows Ruby developers to progromatically access Giphy API V1.

This gem supports all endpoints that are officially documented by Giphy. Please refer to [Giphy API Documentation](https://developers.giphy.com/docs/) for more details about endpoints and parameters.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'giphy_api', github: 'faragorn/giphy_api'
```

And then execute:

    $ bundle install

RubyGems version is coming soon!

## Configuration

```ruby
GiphyAPI.configure do |config|
  config.api_key = 'YOUR API KEY' # set to ENV['GIPHY_API_KEY'] by default
  config.json_parser = JSONParser # set to JSON by default
  config.api_prefix = 'v1'       # set to 'v1' by default
end
```

Your custom JSON parser should implement `load` method.

## Usage

### Requesting Gifs

```ruby
# Searching Gifs by keyword:
# http://api.giphy.com/v1/gifs/search?q=aliens&api_key=YOUR_API_KEY
gifs = GiphyAPI::Gif.search('aliens')
# http://api.giphy.com/v1/gifs/search?q=aliens&limit=10&offset=20&rating=g&lang=en&api_key=YOUR_API_KEY
gifs = GiphyAPI::Gif.search('aliens', limit: 10, offset: 20, rating: 'g', lang: 'en')
#
# Trending Gifs:
# http://api.giphy.com/v1/gifs/trending?api_key=YOUR_API_KEY
gifs = GiphyAPI::Gif.trending()
# http://api.giphy.com/v1/gifs/trending?limit=20&rating=g&api_key=YOUR_API_KEY
gifs = GiphyAPI::Gif.trending(limit: 20, rating: 'g')
#
# Random Gif:
# http://api.giphy.com/v1/gifs/random?api_key=YOUR_API_KEY
gif = GiphyAPI::Gif.random()
# http://api.giphy.com/v1/gifs/random?tag=burito&rating=g&api_key=YOUR_API_KEY
gif = GiphyAPI::Gif.random(tag: 'burrito', rating: 'g')
#
# Translated Gif:
# http://api.giphy.com/v1/gifs/translate?s=moo&api_key=YOUR_API_KEY
gif = GiphyAPI::Gif.translate('moo')
#
# Get a Gif by id:
# http://api.giphy.com/v1/gifs/jWq123?api_key=YOUR_API_KEY
gif = GiphyAPI::Gif.find('jWq123')
#
# Get Gifs by a list of ids:
# http://api.giphy.com/v1/gifs?ids=jWq123,Pv01&api_key=YOUR_API_KEY
gifs = GiphyAPI::Gif.find_by_ids('jWq123', 'Pv01')
```

### Requesting Stickers
```ruby
# Searching Stickers by keyword:
# http://api.giphy.com/v1/stickers/search?q=aliens&api_key=YOUR_API_KEY
stickers = GiphyAPI::Sticker.search('aliens')
# http://api.giphy.com/v1/stickers/search?q=aliens&limit=10&offset=20&rating=g&lang=en&api_key=YOUR_API_KEY
stickers = GiphyAPI::Sticker.search('aliens', limit: 10, offset: 20, rating: 'g', lang: 'en')
#
# Trending Stickers:
# http://api.giphy.com/v1/stickers/trending?api_key=YOUR_API_KEY
stickers = GiphyAPI::Sticker.trending()
# http://api.giphy.com/v1/stickers/trending?limit=20&rating=g&api_key=YOUR_API_KEY
stickers = GiphyAPI::Sticker.trending(limit: 20, rating: 'g')
#
# Random Sticker:
# http://api.giphy.com/v1/stickers/random?api_key=YOUR_API_KEY
sticker = GiphyAPI::Sticker.random()
# http://api.giphy.com/v1/stickers/random?tag=burito&rating=g&api_key=YOUR_API_KEY
sticker = GiphyAPI::Sticker.random(tag: 'burrito', rating: 'g')
#
# Translated Sticker:
# http://api.giphy.com/v1/stickers/translate?s=moo&api_key=YOUR_API_KEY
sticker = GiphyAPI::Sticker.translate('moo')
```

### Pagination

Following pagination fields will be set to all collections if Giphy API returns a `pagination` object:

```ruby
gifs.total_count  # Total number of items available.
gifs.offset       # Position in pagination.
gifs.count        # Total number of items returned.
```

These attributes will be set to `nil` if nothing was returned.

## Development and Contributing

1. Create a fork of the original repo.
1. After checking out your fork repo, run `bundle setup` to install dependencies.
1. Create a new branch and add your changes there.
1. Commit your changes and create a pull request.

**Note:** run `rake test` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment. <br />
Bug reports and pull requests are welcome on GitHub at https://github.com/faragorn/giphy_api.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TO Do List

* More tests for Image, User and Base classes
* Configure Travis CI
* Generate Code coverage reports
* Add rubocop for syntax checking
* Create a CLI
