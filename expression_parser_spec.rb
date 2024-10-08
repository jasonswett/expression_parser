require_relative "./expression"

RSpec.describe "expression parser" do
  context "the expression is a constant" do
    let!(:expression_tree) { Expression.new("5").parse }

    it "has a root of 5" do
      expect(expression_tree.root).to eq(5)
    end

    it "has no left child" do
      expect(expression_tree.left_child).to be nil
    end

    it "has no right child" do
      expect(expression_tree.right_child).to be nil
    end
  end

  context "when the expression involves multiplication with an explicit operator" do
    let!(:expression_tree) { Expression.new("2*x").parse }

    it "has a root of *" do
      expect(expression_tree.root).to eq("*")
    end

    it "has a left child of 2" do
      expect(expression_tree.left_child.value).to eq(2)
    end

    it "has a right child of 'x'" do
      expect(expression_tree.right_child.value).to eq("x")
    end
  end

  context "when the expression involves multiplication without an explicit operator" do
    context "variable is 'x'" do
      let!(:expression_tree) { Expression.new("2x").parse }

      it "has a root of *" do
        expect(expression_tree.root).to eq("*")
      end

      it "has a left child of 2" do
        expect(expression_tree.left_child.value).to eq(2)
      end

      it "has a right child of 'x'" do
        expect(expression_tree.right_child.value).to eq("x")
      end
    end

    context "variable is not 'x'" do
      let!(:expression_tree) { Expression.new("2y").parse }

      it "has a root of *" do
        expect(expression_tree.root).to eq("*")
      end
    end
  end

  context "when the expression involves division" do
    let!(:expression_tree) { Expression.new("x/3").parse }

    it "has a root of /" do
      expect(expression_tree.root).to eq("/")
    end

    it "has a left child of 'x'" do
      expect(expression_tree.left_child.value).to eq("x")
    end

    it "has a right child of 3" do
      expect(expression_tree.right_child.value).to eq(3)
    end
  end

  context "addition" do
    let!(:expression_tree) { Expression.new("x + 5").parse }

    it "has a root of +" do
      expect(expression_tree.root).to eq("+")
    end

    it "has a left child of 'x'" do
      expect(expression_tree.left_child.value).to eq("x")
    end

    it "has a right child of 5" do
      expect(expression_tree.right_child.value).to eq(5)
    end
  end

  context "subtraction" do
    let!(:expression_tree) { Expression.new("x - 5").parse }

    it "has a root of -" do
      expect(expression_tree.root).to eq("-")
    end

    it "has a left child of 'x'" do
      expect(expression_tree.left_child.value).to eq("x")
    end

    it "has a right child of 5" do
      expect(expression_tree.right_child.value).to eq(5)
    end
  end

  context "nesting" do
    let!(:expression_tree) { Expression.new("2x + 5").parse }

    it "has a root of +" do
      expect(expression_tree.root).to eq("+")
    end

    it "has a left child with a root of *" do
      expect(expression_tree.left_child.root).to eq("*")
    end

    it "has a left child with a left child of 2" do
      expect(expression_tree.left_child.left_child.value).to eq(2)
    end

    it "has a left child with a right child of 'x'" do
      expect(expression_tree.left_child.right_child.value).to eq("x")
    end

    it "has a right child of 5" do
      expect(expression_tree.right_child.value).to eq(5)
    end
  end

  context "parentheses" do
    let!(:expression) { Expression.new("6(x + 3)").parse }

    it "has a root of *" do
      expect(expression.root).to eq("*")
    end

    it "has a left child of 6" do
      expect(expression.left_child.value).to eq(6)
    end

    it "has a right child with a root of +" do
      expect(expression.right_child.root).to eq("+")
    end

    context "subexpression (x + 3)" do
      let!(:subexpression) { expression.right_child }

      it "has a root of +" do
        expect(subexpression.root).to eq("+")
      end

      it "has a left child of 'x'" do
        expect(subexpression.left_child.value).to eq("x")
      end

      it "has a right child of 3" do
        expect(subexpression.right_child.value).to eq(3)
      end
    end
  end

  context "other parentheses" do
    let!(:expression) { Expression.new("a(5 - b)").parse }

    it "has a root of *" do
      expect(expression.root).to eq("*")
    end

    it "has a left child of 'a'" do
      expect(expression.left_child.value).to eq('a')
    end

    it "has a right child with a root of -" do
      expect(expression.right_child.root).to eq("-")
    end

    context "subexpression (5 - b)" do
      let!(:subexpression) { expression.right_child }

      it "has a root of -" do
        expect(subexpression.root).to eq("-")
      end

      it "has a left child of 5" do
        expect(subexpression.left_child.value).to eq(5)
      end

      it "has a right child of 'b'" do
        expect(subexpression.right_child.value).to eq("b")
      end
    end
  end

  context "nested parentheses" do
    let!(:expression) { Expression.new("2(a + (b - 5))").parse }

    it "has a root of *" do
      expect(expression.root).to eq("*")
    end
  end
end
