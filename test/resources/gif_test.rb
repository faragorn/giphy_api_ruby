module GiphyAPI
  class GifTest < Spec

    after do
      FakeWeb.clean_registry
    end

    describe 'get gif by id' do
      let(:gif) { Gif.find('OElzB1cmsqXi8') }

      before do
        fake_request 'gifs/OElzB1cmsqXi8?api_key', fixture: 'gif_by_id'
      end

      it 'must get a single gif by id' do
        gif.id.must_equal 'OElzB1cmsqXi8'
        gif.type.must_equal 'gif'
        gif.slug.must_equal 'dilemma-OElzB1cmsqXi8'
        gif.url.must_equal 'https://giphy.com/gifs/dilemma-OElzB1cmsqXi8'
        gif.bitly_url.must_equal 'http://gph.is/2efZsVK'
        gif.embed_url.must_equal 'https://giphy.com/embed/OElzB1cmsqXi8'
        gif.source.must_equal 'http://makeagif.com/pNSoDf'
        gif.rating.must_equal 'g'
        gif.content_url.must_equal ''
        gif.username.must_equal ''
        gif.tags.must_be_nil
        gif.featured_tags.must_be_nil
        gif.source_tld.must_equal 'makeagif.com'
        gif.source_post_url.must_equal 'http://makeagif.com/pNSoDf'
        gif.update_datetime.must_be_nil
        gif.create_datetime.must_be_nil
        gif.import_datetime.must_equal '2016-10-19 05:05:53'
        gif.trending_datetime.must_equal '0000-00-00 00:00:00'
      end

      it 'must set raw_data to json response' do
        response_json = JSON.parse load_fixture('gif_by_id')
        gif.raw_data.must_equal response_json['data']
      end
    end

    it 'must get trending gifs' do
      fake_request 'gifs/trending?api_key', fixture: 'gifs'
      gifs = Gif.trending
      gifs.count.must_equal 2
      gifs.first.id.must_equal 'xTiTny5Iu35uW0Jl9C'
    end

    it 'must search gifs by keyword' do
      fake_request 'gifs/search?q=hello&api_key', fixture: 'gifs'
      gifs = Gif.search('hello')
      gifs.count.must_equal 2
      gifs.first.id.must_equal 'xTiTny5Iu35uW0Jl9C'
    end

    it 'must find gifs by list of ids' do
      fake_request 'gifs?ids=xTiTny5Iu35uW0Jl9C%2CxUOrw1avEiJvQJlo76&api_key', fixture: 'gifs'
      gifs = Gif.find_by_ids('xTiTny5Iu35uW0Jl9C', 'xUOrw1avEiJvQJlo76')
      gifs.first.id.must_equal 'xTiTny5Iu35uW0Jl9C'
    end

    it 'must get a random gif' do
      fake_request 'gifs/random?api_key', fixture: 'random_gif'
      Gif.random
    end

    it 'must get translated gif' do
      fake_request 'gifs/translate?s=Blah&api_key', fixture: 'gif_by_id'
      Gif.translate 'Blah'
    end
  end
end