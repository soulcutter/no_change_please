require 'spec_helper'

module NoChangePlease
  describe MenuItem do
    subject(:item) { NoChangePlease::MenuItem.new('slice of pizza', "$%.2f" % price) }
    let(:price) { 2.47 }
    let(:name) { 'slice of pizza' }

    it "stores a price" do
      item.price.should == price
    end

    it "stores a name" do
      item.name.should == name
    end

    context '#parse' do
      subject(:item) { MenuItem.parse("#{name},$%.2f" % price) }
      specify { item.name.should == name }
      specify { item.price.should == price }
    end

    context '#valid?' do
      let(:invalid_values) do
        [
          'french fries',
          'french fries,',
          'french fries,$',
          'french fries,$4.',
          'french fries,$4.5',
          'french fries,$4.50,turkey'
        ]
      end
      let(:valid_values) { ['french fries,$4.50', 'french fries,$4'] }

      it "is false for invalid values" do
        invalid_values.each do |value|
          MenuItem.valid?(value).should be_false
        end
      end

      it "is true for valid values" do
        valid_values.each do |value|
          MenuItem.valid?(value).should be_true
        end
      end
    end
  end
end
