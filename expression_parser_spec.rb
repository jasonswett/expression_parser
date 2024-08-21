require_relative "./expression"

RSpec.describe "expression parser" do
  context "the term is a constant" do
    let!(:expression) { Expression.parse("5") }

    it "has a root of 5" do
      expect(expression.root).to eq(5)
    end

    it "has no left child" do
      expect(expression.left_child).to be nil
    end

    it "has no right child" do
      expect(expression.right_child).to be nil
    end
  end

  context "when the term involves multiplication with an explicit operator" do
    let!(:expression) { Expression.parse("2*x") }

    it "has a root of *" do
      expect(expression.root).to eq("*")
    end
  end
end
