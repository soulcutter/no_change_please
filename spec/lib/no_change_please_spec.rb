require 'spec_helper'

describe NoChangePlease do
  let(:pickle) { NoChangePlease::MenuItem.parse('fried pickle,$2') }
  let(:sammich) { NoChangePlease::MenuItem.parse('sammich,$5') }

  it "can load a given file" do
    target_price, menu = NoChangePlease.load_problem(fixture_file('simple_menu.txt'))

    target_price.should == NoChangePlease::Price.parse("$20.00")
    menu.should == [sammich, pickle]
  end

  context "#solve" do
    it "can find a combination of menu items resulting in exact change" do
      solution = NoChangePlease.solve(*NoChangePlease.load_problem(fixture_file('simple_menu.txt')))
      solution.should == [sammich, sammich, sammich, sammich]
    end

    it "returns an empty array for unsolvable problems" do
      solution = NoChangePlease.solve(*NoChangePlease.load_problem(fixture_file('unsolvable_menu.txt')))
      solution.should == []
    end
  end

end