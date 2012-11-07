module NoChangePlease
  class Problem
    attr_reader :target_price, :menu

    def initialize(target_price, menu)
      @target_price = target_price
      @menu =  menu.dup.sort! { |x, y| y.price <=> x.price }.freeze
    end

    def solution
      @solution ||= solve(target_price, menu).sort { |x, y| y.price <=> x.price }
    end

    private

    def solve(target_price, menu)
      return [] if menu.empty?

      exact_match = menu.find { |x| x.price == target_price }
      return [exact_match] if exact_match

      # eliminate menu items more expensive than the target price
      menu = menu.select { |x| x.price < target_price }

      # subtract each menu item from the target price and try to solving the resulting target price recursively
      solutions = menu.map { |menu_item| [menu_item] + solve(target_price - menu_item.price, menu) }

      # get rid of solutions that do not equal our target price
      solutions.reject! { |solution| solution.inject(0) { |sum, menu_item| sum + menu_item.price } != target_price }

      solutions.empty? ? solutions : solutions.first
    end
  end
end