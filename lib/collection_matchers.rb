module CollectionMatchers

  def ascend
    ascend_on{|x| x}
  end

  def ascend_on(&determine_value_block)
    OrderMatcher.new("ascend", determine_value_block) {|x1, x2| x1 < x2 }
  end

  def descend
    descend_on{|x| x}
  end

  def descend_on(&determine_value_block)
    OrderMatcher.new("descend", determine_value_block) {|x1, x2| x1 > x2 }
  end

  class OrderMatcher
    def initialize(order_text, determine_value_block, &comparison_block)
      @order_text = order_text;
      @determine_ordered_value_block = determine_value_block
      @comparison_block = comparison_block
    end

    def matches?(actuals)
      @actual_values = determine_values(actuals)
      previous_value = nil
      @actual_values.each do |value|
        if !previous_value.nil?
          return false if !@comparison_block.call(previous_value, value)
        end
        previous_value = value
      end
      return true
    end

    def failure_message
      "expected #{@actual_values.join(',')} to #{@order_text}"
    end
    
    def negative_failure_message
      "expected #{@actual_values.join(',')} not to #{@order_text}"
    end

    private

    def determine_values(actuals)
      actuals.map{|actual| @determine_ordered_value_block.call(actual)}
    end

  end
end