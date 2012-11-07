require 'no_change_please/menu'
require 'no_change_please/menu_item'

module NoChangePlease
  extend self

  def load_problem(file)
    target = nil
    menu = []

    IO.foreach(file) do |line|
      line = line.chomp
      if target.nil?
        target = Price.parse(line)
        next
      end
      menu << MenuItem.parse(line)
    end
    [target, menu]
  end

  def solve(target_price, menu)
    menu = menu.dup.sort! { |x, y| x.price <=> y.price }.reverse

    return [] if menu.empty?

    exact_match = menu.find { |x| x.price == target_price }
    return [exact_match] if exact_match

    # eliminate menu items more expensive than the target price
    menu.select! { |x| target_price > x.price }

    # subtract each menu item from the target price and try to solving the resulting target price recursively
    solutions = menu.map { |menu_item| [menu_item] + solve(target_price - menu_item.price, menu) }

    # get rid of solutions that do not equal our target price
    solutions.reject! { |solution| solution.inject(0) { |sum, menu_item| sum + menu_item.price } != target_price }

    solutions.empty? ? solutions : solutions.first
  end
end
