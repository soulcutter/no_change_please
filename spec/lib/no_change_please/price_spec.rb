module NoChangePlease
  describe Price do
    subject(:price) { Price.new amount }
    let(:amount) { 4.25 }

    context "is comparable with" do
      context "another Price object" do
        specify { price.should > Price.new(amount - 1) }
        specify { price.should < Price.new(amount + 1) }
        specify { price.should == Price.new(amount) }
      end

      context "a Numeric object" do
        specify { price.should > (amount - 1) }
        specify { price.should < (amount + 1) }
        specify { price.should == amount }
      end
    end

    context "coercion to/from Numeric" do
      specify { (Price.new(8) - 4.5).should == Price.new(3.5) }
      specify { (8 - Price.new(4.5)).should == Price.new(3.5) }
    end

    it "ignores precision beyond hundredths" do
      (Price.new(4.999) + Price.new(0.001)).should == Price.new(4.99)
    end

    context 'string format validation' do
      let(:valid_values)   { ['$4', '$4.25', '$235.34'] }
      let(:invalid_values) { ['4.25', 'asdf', nil, '$4.3', '.3'] }

      it "raises ArgumentError trying to instantiate bad string values" do
        invalid_values.each do |value|
          expect { Price.parse(value) }.to raise_error(ArgumentError)
        end
      end

      context '#valid?' do
        it "is true for valid values" do
          valid_values.each do |value|
            Price.valid?(value).should be_true
          end
        end

        it "is false for invalid values" do
          invalid_values.each do |value|
            Price.valid?(value).should be_false
          end
        end
      end
    end

    context 'addition' do
      specify { (price + price).should be_a(Price) }

      it "results in a new Price with summed amounts" do
        (price + price).should == Price.new(amount + amount)
      end
    end
  end
end