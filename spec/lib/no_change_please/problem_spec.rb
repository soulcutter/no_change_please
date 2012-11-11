require 'spec_helper'

module NoChangePlease
  describe Problem do
    context "#solution" do
      subject(:solution) { Problem.new(target_price, [pizza, soda]).solution }
      let(:pizza) { MenuItem.new('pizza', '$5.00') }
      let(:soda)  { MenuItem.new('soda', '$3.00') }

      context "for an unsolvable problem" do
        let(:target_price) { 9.99 }
        it { should == [] }
      end

      context "for a solvable problem" do
        let(:target_price) { 10 }
        it { should == [pizza, pizza] }
      end

      context "for a problem that can only be solved by a combination" do
        let(:target_price) { 8 }
        it { should == [pizza, soda] }
      end
    end
  end
end