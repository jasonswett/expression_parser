require_relative "./config"
require_relative "./expression_tree"

class Expression
  OPERATORS = %w(+ / *)

  def initialize(value)
    @value = value
  end

  def parse
    @value.strip!

    if constant?(@value)
      return ExpressionTree.new(root: @value.to_i)
    end

    if @value.length == 1
      return ExpressionTree.new(root: @value)
    end

    OPERATORS.each do |operator|
      if @value.include?(operator)
        left_child, right_child = split_on(@value, operator)

        return ExpressionTree.new(
          root: operator,
          left_child:,
          right_child:
        )
      end
    end

    left_child, right_child = split_on(@value, "")

    ExpressionTree.new(
      root: "*",
      left_child:,
      right_child:
    )
  end

  def constant?(value)
    @value.to_i.to_s == @value.strip
  end

  def split_on(value, operator)
    value.split(operator).map do |child_expression_value|
      Expression.new(child_expression_value).parse
    end
  end
end
