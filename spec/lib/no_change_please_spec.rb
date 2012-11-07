require 'spec_helper'

describe NoChangePlease do
  let(:pickle) { NoChangePlease::MenuItem.parse('fried pickle,$2') }
  let(:sammich) { NoChangePlease::MenuItem.parse('sammich,$5') }

  it "can load a given file" do
    problem = NoChangePlease.load_problem(fixture_file('simple_menu.txt'))

    problem.target_price.should == 20
    problem.menu.should == [sammich, pickle]
  end

  it "can solve the sample file" do
    NoChangePlease.load_problem(fixture_file('menu.txt')).solution.should_not == []
  end
end