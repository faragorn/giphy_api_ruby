module GiphyAPI
  class UserTest < Spec
    it 'must initialize a new user from attributes' do
      attributes = {
        'avatar_url' => 'http://avatar.jpg',
        'banner_url' => 'http://banner.jpg',
        'profile_url' => 'http://profile.com',
        'username' => 'giphy_user',
        'display_name' => 'Giphy',
        'twitter' => '@giphy'
      }
      user = User.new attributes
      user.raw_data.must_equal attributes
      user.avatar_url.must_equal 'http://avatar.jpg'
      user.banner_url.must_equal 'http://banner.jpg'
      user.profile_url.must_equal 'http://profile.com'
      user.username.must_equal 'giphy_user'
      user.display_name.must_equal 'Giphy'
      user.twitter.must_equal '@giphy'
    end
  end
end