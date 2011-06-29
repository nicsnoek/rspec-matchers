require "collection_matchers"
include CollectionMatchers

describe CollectionMatchers do

  describe "ascend" do
    context "'should'" do
      it "meets expectation when subject is ascending" do
        [1, 2].should ascend
      end

      it "raises ExpectationNotMetError when subject is not ascending" do
        lambda { [1, 2, 3, 2, 3].should ascend }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end

    context "'should_not'" do
      it "meet expectation when subject is not ascending" do
        [1, 1].should_not ascend
      end

      it "raises ExpectationNotMetError  when subject is ascending" do
        lambda { [1, 2, 3].should_not ascend }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end

  end

  describe "ascend on" do
    context "'should'"
    it "meets expectation when subject's given attribute is ascending" do
      ["1", "12"].should ascend_on(&:length)
    end
    it "raises ExpectationNotMetError when subject is not ascending" do
      lambda { ["12", "1"].should ascend_on(&:length) }.should raise_error RSpec::Expectations::ExpectationNotMetError
    end
    it "meets expectation when given function of subject is ascending" do
      ["2", "1"].should ascend_on {|s| 1.0 / s.to_i }
    end
    it "raises ExpectationNotMetError when subject is not ascending" do
      lambda { ["1", "2"].should ascend_on {|s| 1.0 / s.to_i } }.should raise_error RSpec::Expectations::ExpectationNotMetError
    end
  end

  describe "descend" do
    context "'should'" do
      it "meet expectation when subject is descending" do
        [2, 1, 0, -1].should descend
      end

      it "raises ExpectationNotMetError when subject is not descending" do
        lambda { [1, 2, 2].should descend }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end

    context "'should_not'" do
      it "meet expectation when subject is not descending" do
        [1, 1].should_not descend
      end

      it "raises ExpectationNotMetError when subject is descending" do
        lambda { [3, 2, 1].should_not descend }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end

  end

  describe "descend on" do
    context "'should'" do
      it "meets expectation when subject's given attribute is descending" do
        ["12", "1"].should descend_on(&:length)
      end
      it "raises ExpectationNotMetError when subject is not descending" do
        lambda { ["1", "12"].should descend_on(&:length) }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
      it "meets expectation when given function of subject is descending" do
        ["1", "2"].should descend_on {|s| 1.0 / s.to_i }
      end
      it "raises ExpectationNotMetError when subject is not descending" do
        lambda { ["2", "1"].should descend_on {|s| 1.0 / s.to_i } }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end
  end

  describe "Some Bizarre Custom Matcher" do

    def have_alternating_signs_on(&determine_value_block)
      OrderMatcher.new("alternate sign", determine_value_block) {|x1, x2| x1 > 0 ? (x2 < 0) : (x2 > 0) }
    end

    def have_alternating_signs
      have_alternating_signs_on{|x| x}
    end

    context "'should'" do
      it "meets expectation" do
        [2, -1, 5].should have_alternating_signs
      end
      it "raises ExpectationNotMetError when expectation not met" do
        lambda { [1, -2, -3].should have_alternating_signs }.should raise_error RSpec::Expectations::ExpectationNotMetError
      end
    end
  end


end
