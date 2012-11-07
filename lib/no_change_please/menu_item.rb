require 'no_change_please/price'

module NoChangePlease
  class MenuItem < Struct.new(:name, :price)
    def initialize(name, price)
      super(name, Price.parse(price))
    end

    def to_s
      "#{name},#{price}"
    end

    def self.parse(str)
      raise ArgumentError.new("Cannot parse line: #{str}") unless valid?(str)
      MenuItem.new(*str.split(','))
    end

    def self.valid?(str)
      parts = str.split(',')
      parts.size == 2 && Price.valid?(parts[1])
    end
  end
end