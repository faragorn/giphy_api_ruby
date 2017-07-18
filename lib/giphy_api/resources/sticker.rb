module GiphyAPI
  class Sticker < Base
    raw_data_attr_accessor :type, :id, :slug, :url, :bitly_url, :embed_url, :source, :rating, :content_url, :username, :tags, :featured_tags, 
                           :source_tld, :source_post_url, :update_datetime, :create_datetime, :import_datetime, :trending_datetime
    attr_accessor :images, :user

    class << self
      def search keyword, **options
        find_with_scope('/search', :all, options.merge(q: keyword))
      end

      def trending **options
        find_with_scope('/trending', :all, options)
      end

      def translate term, **options
        find_with_scope('/translate', :one, options.merge(s: term))
      end

      def random **options
        find_with_scope('/random', :one, options)
      end
    end

    def initialize attributes = {}
      super(attributes)
      self.user = User.new raw_data['user'] if raw_data['user']
      self.images = (raw_data['images'] || Image.extract_images(raw_data)).collect do |type, image|
        [type, Image.new(image)]
      end.to_h
    end
  end
end