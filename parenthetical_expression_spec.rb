require_relative "./expression"

RSpec.describe ParentheticalExpression do
  context "nested parentheses" do
    let!(:parenthetical_expression) do
      ParentheticalExpression.new("2(a + (b - 5))")
    end

    describe "#value_inside_parentheses" do
      it "is 'a + (b - 5)'" do
        expect(parenthetical_expression.value_inside_parentheses).to eq("a + (b - 5)")
      end
    end
  end
end
