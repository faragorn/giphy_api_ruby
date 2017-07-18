module GiphyAPI
  class Image
    include RawDataAttributes

    IMAGE_TYPES = %w(original fixed_height fixed_height_still fixed_height_downsampled fixed_width 
                     fixed_width_still fixed_width_downsampled fixed_height_small fixed_height_small_still 
                     fixed_width_small fixed_width_small_still downsized downsized_still downsized_large 
                     downsized_medium downsized_small original original_still looping preview preview_gif
                  ).freeze

    raw_data_attr_accessor :url, :width, :height, :size, :frames, :mp4, :mp4_size, :webp, :webp_size

    def self.extract_images payload
      image_type_mapping = { "image" => "original" }

      attr_regexp = "(#{accessible_raw_attributes.join('|')})"
      type_regexp = "(#{IMAGE_TYPES.join('|')})"

      image_attribute_regexp = Regexp.new("^#{type_regexp}_#{attr_regexp}$")
      images = {}
      payload.each do |key, value|
        next unless image_attribute_regexp.match(key)
        image_type = key.sub Regexp.new("_#{attr_regexp}$"), ''
        image_attribute = key.sub Regexp.new("^#{type_regexp}_"), ''

        type_mapping_value = image_type_mapping[image_type] || image_type

        images[type_mapping_value] ||= {}
        images[type_mapping_value][image_attribute] = value
      end
      images
    end

    def initialize(attributes = {})
      assign_raw_data(attributes)
    end
  end
end