module CollectionMatchers

  def ascend
    ascend_on{|x| x}
  end

  def ascend_on(&determine_value_block)
    ConsecutiveItemMatcher.new("ascend", determine_value_block) {|x1, x2| x1 < x2 }
  end

  def descend
    descend_on{|x| x}
  end

  def descend_on(&determine_value_block)
    ConsecutiveItemMatcher.new("descend", determine_value_block) {|x1, x2| x1 > x2 }
  end

  class ConsecutiveItemMatcher
    def initialize(expectation_text, determine_value_block, &expectation_block)
      @expectation_text = expectation_text;
      @determine_value_block = determine_value_block
      @expectation_block = expectation_block
    end

    def matches?(actual_consecutives)
      @consecutive_values = determine_values(actual_consecutives)
      previous_value = nil
      @consecutive_values.each_with_index do |value, index|
        if index > 0
          return false if !@expectation_block.call(previous_value, value)
        end
        previous_value = value
      end
      return true
    end

    def failure_message
      "expected #{@consecutive_values.join(',')} to #{@expectation_text}"
    end
    
    def negative_failure_message
      "expected #{@consecutive_values.join(',')} not to #{@expectation_text}"
    end

    private

    def determine_values(actuals)
      actuals.map{|actual| @determine_value_block.call(actual)}
    end

  end
end