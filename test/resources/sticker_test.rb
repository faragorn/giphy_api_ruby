module GiphyAPI
  class StickerTest < Spec

    after do
      FakeWeb.clean_registry
    end

    it 'must get trending stickers' do
      fake_request 'stickers/trending?api_key', fixture: 'gifs'
      gifs = Sticker.trending
      gifs.count.must_equal 2
      gifs.first.id.must_equal 'xTiTny5Iu35uW0Jl9C'
    end

    it 'must search stickers by keyword' do
      fake_request 'stickers/search?q=hello&api_key', fixture: 'gifs'
      gifs = Sticker.search('hello')
      gifs.count.must_equal 2
      gifs.first.id.must_equal 'xTiTny5Iu35uW0Jl9C'
    end

    it 'must get a random sticker' do
      fake_request 'stickers/random?api_key', fixture: 'random_gif'
      Sticker.random
    end

    it 'must get translated sticker' do
      fake_request 'stickers/translate?s=Blah&api_key', fixture: 'gif_by_id'
      Sticker.translate 'Blah'
    end
  end
end