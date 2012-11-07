require 'no_change_please/problem'
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

    Problem.new(target, menu)
  end
end
