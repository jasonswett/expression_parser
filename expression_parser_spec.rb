require_relative "./expression"
require "pry"

RSpec.describe "expression parser" do
  context "the expression is a constant" do
    let!(:expression) { Expression.parse("5") }

    it "has a root of 5" do
      expect(expression.root.value).to eq(5)
    end

    it "has no left child" do
      expect(expression.left_child.value).to be nil
    end

    it "has no right child" do
      expect(expression.right_child.value).to be nil
    end
  end

  context "when the expression involves multiplication with an explicit operator" do
    let!(:expression) { Expression.parse("2*x") }

    it "has a root of *" do
      expect(expression.root.value).to eq("*")
    end

    it "has a left child of 2" do
      expect(expression.left_child.value).to eq(2)
    end

    it "has a right child of 'x'" do
      expect(expression.right_child.value).to eq("x")
    end
  end

  context "when the expression involves multiplication without an explicit operator" do
    context "variable is 'x'" do
      let!(:expression) { Expression.parse("2x") }

      it "has a root of *" do
        expect(expression.root.value).to eq("*")
      end

      it "has a left child of 2" do
        expect(expression.left_child.value).to eq(2)
      end

      it "has a right child of 'x'" do
        expect(expression.right_child.value).to eq("x")
      end
    end

    context "variable is not 'x'" do
      let!(:expression) { Expression.parse("2y") }

      it "has a root of *" do
        expect(expression.root.value).to eq("*")
      end
    end
  end

  context "when the expression involves division" do
    let!(:expression) { Expression.parse("x/3") }

    it "has a root of /" do
      expect(expression.root.value).to eq("/")
    end

    it "has a left child of 'x'" do
      expect(expression.left_child.value).to eq("x")
    end

    it "has a right child of 3" do
      expect(expression.right_child.value).to eq(3)
    end
  end

  context "addition" do
    let!(:expression) { Expression.parse("x + 5") }

    it "has a root of +" do
      expect(expression.root.value).to eq("+")
    end

    it "has a left child of 'x'" do
      expect(expression.left_child.value).to eq("x")
    end

    it "has a right child of 5" do
      expect(expression.right_child.value).to eq(5)
    end
  end

  context "nesting" do
    let!(:expression) { Expression.parse("2x + 5") }

    it "has a root of +" do
      expect(expression.root.value).to eq("+")
    end

    it "has a left child with a root of *" do
      expect(expression.left_child.root.value).to eq("*")
    end

    it "has a left child with a left child of 2" do
      expect(expression.left_child.left_child.value).to eq(2)
    end

    it "has a left child with a right child of 'x'" do
      expect(expression.left_child.right_child.value).to eq("x")
    end

    it "has a right child of 5" do
      expect(expression.right_child.value).to eq(5)
    end
  end
end
