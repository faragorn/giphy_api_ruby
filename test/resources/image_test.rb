module GiphyAPI
  class ImageTest < Spec
    it 'must initialize a new image from attributes' do
      attributes = {
        'url' => 'http://image.gif',
        'width' => '200',
        'height' => '300',
        'size' => '5000',
        'frames' => '100',
        'mp4' => 'http://image.mp4',
        'mp4_size' => '6000',
        'webp' => 'http://image.webp',
        'webp_size' => '7000'
      }
      image = Image.new attributes
      image.raw_data.must_equal attributes
      image.url.must_equal 'http://image.gif'
      image.width.must_equal '200'
      image.height.must_equal '300'
      image.size.must_equal '5000'
      image.frames.must_equal '100'
      image.mp4.must_equal 'http://image.mp4'
      image.mp4_size.must_equal '6000'
      image.webp.must_equal 'http://image.webp'
      image.webp_size.must_equal '7000'
    end
  end
end