class ParentheticalExpression
  REGEX = /([a-zA-Z\d]+)\(([^)]+)\)/

  def initialize(value)
    @value = value
  end

  def parse
    ExpressionTree.new(
      root: "*",
      left_child: value_before_parentheses,
      right_child: value_inside_parentheses
    )
  end

  private

  def value_before_parentheses
    Expression.new(match_data[1]).parse
  end

  def value_inside_parentheses
    Expression.new(match_data[2]).parse
  end

  def match_data
    @value.match(REGEX)
  end
end
