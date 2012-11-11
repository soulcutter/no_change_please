module NoChangePlease
  class Price
    include Comparable

    attr_reader :amount

    def initialize(amount)
      @amount = (amount * 100).floor
    end

    def <=>(obj)
      amount <=> coerce(obj)[0].amount
    end

    def +(obj)
      sum = amount + coerce(obj)[0].amount
      Price.new(sum / 100.0)
    end

    def -(obj)
      result = amount - coerce(obj)[0].amount
      Price.new(result / 100.0)
    end

    def to_s
      "$%d.%02d" % [(amount / 100), (amount % 100)]
    end

    def coerce(other)
      case other
        when Price
          [other, self]
        when Numeric
          [Price.new(other), self]
        else
          raise TypeError.new("Cannot coerce #{other.inspect} to a Price")
      end
    end

    def self.parse(price)
      raise ArgumentError.new("Invalid price string: #{price.inspect}") unless Price.valid?(price)
      Price.new price[1..-1].to_f
    end

    def self.valid?(str)
      str =~ /\A\$\d+(\.\d{2})?\z/
    end
  end
end