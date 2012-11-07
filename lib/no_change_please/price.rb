module NoChangePlease
  class Price
    include Comparable

    attr_reader :amount

    def initialize(amount)
      @amount = amount
    end

    def <=>(obj)
      obj = coerce(obj)[1]
      amount <=> obj.amount
    end

    def +(obj)
      obj = coerce(obj)[1]
      Price.new(amount + obj.amount)
    end

    def -(obj)
      obj = coerce(obj)[1]
      Price.new(amount - obj.amount)
    end

    def to_s
      "$%.2f" % amount
    end

    def coerce(other)
      case other
        when Price
          [self, other]
        when Numeric
          [self, Price.new(other)]
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