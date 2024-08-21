require_relative "./expression"

RSpec.describe "expression parser" do
  context "the term is a constant" do
    it "has a root of 5" do
      expression = Expression.parse("5")
      expect(expression.value).to eq(5)
    end

    it "has no left child" do
      expression = Expression.parse("5")
      expect(expression.left_child).to be nil
    end

    it "has no right child" do
      expression = Expression.parse("5")
      expect(expression.right_child).to be nil
    end
  end
end
