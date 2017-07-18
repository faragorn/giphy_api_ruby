module GiphyAPI
  class User
    include RawDataAttributes

    raw_data_attr_accessor :username, :display_name, :twitter, :avatar_url, :banner_url, :profile_url

    def initialize attributes = {}
      assign_raw_data(attributes)
    end
  end
end