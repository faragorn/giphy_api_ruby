require 'test_helper'

class BaseTest < GiphyAPI::Spec
  let(:klass) { Class.new(GiphyAPI::Base) }
  describe 'raw_data_attr_accessor' do
    it 'must define setter and getter for specifed attributes' do
      klass.raw_data_attr_accessor :attr1, :attr2
      klass.instance_methods.must_include :attr1
      klass.instance_methods.must_include :attr1=
      klass.instance_methods.must_include :attr2
      klass.instance_methods.must_include :attr2=
    end

    it 'must list specified attributes in accessible_raw_attributes as strings' do
      klass.raw_data_attr_accessor :attr1, :attr2
      klass.accessible_raw_attributes.must_equal ['attr1', 'attr2']
    end

    it 'must add specified attributes to existing accessible_raw_attributes' do
      klass.raw_data_attr_accessor :attr1
      klass.accessible_raw_attributes.must_equal ['attr1']
      klass.raw_data_attr_accessor :attr2
      klass.accessible_raw_attributes.must_equal ['attr1', 'attr2']
    end

    it 'must define setter and getter on a subsequent accessible_raw_attributes calls' do
      klass.raw_data_attr_accessor :attr1
      klass.raw_data_attr_accessor :attr2
      klass.instance_methods.must_include :attr1
      klass.instance_methods.must_include :attr1=
      klass.instance_methods.must_include :attr2
      klass.instance_methods.must_include :attr2=
    end

    it 'raw_data getter returns raw_data value with the specified key' do
      klass.raw_data_attr_accessor :attr1
      instance = klass.new('attr1' => 'attr1-value')
      instance.attr1.must_equal 'attr1-value'
    end

    it 'raw_data setter sets raw_data value with the specified key' do
      klass.raw_data_attr_accessor :attr1
      instance = klass.new
      instance.attr1 = 'attr1-value'
      instance.attr1.must_equal 'attr1-value'
      instance.raw_data['attr1'].must_equal 'attr1-value'
    end
  end
end
