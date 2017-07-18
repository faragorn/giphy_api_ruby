module GiphyAPI
  module RawDataAttributes

    def assign_raw_data raw_data
      self.raw_data = raw_data
    end

    def self.included mod
      mod.send(:attr_accessor, :raw_data)
      mod.extend ClassMethods
    end

    module ClassMethods
      def raw_data_attr_accessor *attrs
        @accessible_raw_attributes = accessible_raw_attributes + attrs.map!(&:to_s)
        attrs.each do |attr|
          define_method attr do
            raw_data[attr]
          end
          define_method "#{attr}=" do |value|
            raw_data[attr] = value
          end
        end
      end

      def accessible_raw_attributes
        @accessible_raw_attributes ||= []
      end
    end
  end
end
